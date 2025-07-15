import Foundation
import AVFoundation

@objc public class NativeAudio: NSObject {
    private let audioSession = AVAudioSession.sharedInstance()
    private let queue = DispatchQueue(
        label: "com.kolirt.plugins.native_audio.queue",
        attributes: .concurrent
    )

    private var _enableAutoInterruptionHandling = true
    private var _enableAutoIosSessionDeactivation = true

    private var assetPlayers: [String: AssetPlayer] = [:]
    private var pausedByInterruptionAssetIds: [String] = []
    private var temporaryFileURLs: [String: URL] = [:]

    deinit {
        cleanupTemporaryFiles()
    }

    public var enableAutoInterruptionHandling: Bool {
        get {
            return self.queue.sync {
                return self._enableAutoInterruptionHandling
            }
        }
        set(newValue) {
            self.queue.async(flags: .barrier) {
                self._enableAutoInterruptionHandling = newValue
            }
        }
    }

    public var enableAutoIosSessionDeactivation: Bool {
        get {
            return self.queue.sync {
                return self._enableAutoIosSessionDeactivation
            }
        }
        set(newValue) {
            self.queue.async(flags: .barrier) {
                self._enableAutoIosSessionDeactivation = newValue
            }
        }
    }

    @objc public func configureSession(
        enableAutoInterruptionHandling: NSNumber?,
        enableAutoIosSessionDeactivation: NSNumber?,
        iosCategory: String?,
        iosMode: String?,
        iosOptions: [String]?
    ) throws {
        if let enableAutoInterruptionHandlingBool = enableAutoInterruptionHandling?.boolValue {
            self.enableAutoInterruptionHandling = enableAutoInterruptionHandlingBool
        }

        if let enableAutoIosSessionDeactivationBool = enableAutoIosSessionDeactivation?.boolValue {
            self.enableAutoIosSessionDeactivation = enableAutoIosSessionDeactivationBool
        }

        if iosCategory != nil || iosMode != nil || iosOptions != nil {
            let categoryRaw = iosCategory ?? "ambient"
            let validCategoryMap: [String: AVAudioSession.Category] = [
                "ambient": .ambient,
                "multiRoute": .multiRoute,
                "playAndRecord": .playAndRecord,
                "playback": .playback,
                "record": .record,
                "soloAmbient": .soloAmbient,
            ]

            guard let avCategory = validCategoryMap[categoryRaw] else {
                throw NSError(
                    domain: "NativeAudio", code: -4,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid iOS category: \(categoryRaw)"]
                )
            }

            let modeRaw = iosMode ?? "default"
            let validModeMap: [String: AVAudioSession.Mode] = [
                "default": .default,
                "gameChat": .gameChat,
                "measurement": .measurement,
                "moviePlayback": .moviePlayback,
                "spokenAudio": .spokenAudio,
                "videoChat": .videoChat,
                "videoRecording": .videoRecording,
                "voiceChat": .voiceChat,
                "voicePrompt": .voicePrompt,
            ]

            guard let avMode = validModeMap[modeRaw] else {
                throw NSError(
                    domain: "NativeAudio", code: -5,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid iOS mode: \(modeRaw)"]
                )
            }

            var avOptions: AVAudioSession.CategoryOptions = []
            if let optionsRaw = iosOptions {
                var validOptionMap: [String: AVAudioSession.CategoryOptions] = [
                    "mixWithOthers": .mixWithOthers,
                    "duckOthers": .duckOthers,
                    "interruptSpokenAudioAndMixWithOthers": .interruptSpokenAudioAndMixWithOthers,
                    "allowBluetoothA2DP": .allowBluetoothA2DP,
                    "allowAirPlay": .allowAirPlay,
                    "defaultToSpeaker": .defaultToSpeaker,
                ]

                // Add iOS 14.5+ specific option if available
                if #available(iOS 14.5, *) {
                    validOptionMap["overrideMutedMicrophoneInterruption"] =
                        .overrideMutedMicrophoneInterruption
                }

                for option in optionsRaw {
                    if let categoryOption = validOptionMap[option] {
                        avOptions.insert(categoryOption)
                    } else {
                        throw NSError(
                            domain: "NativeAudio", code: -6,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid iOS option: \(option)"]
                        )
                    }
                }
            }

            try self.audioSession.setCategory(avCategory, mode: avMode, options: avOptions)
        }
    }

    @objc public func pauseAllForInterruption() -> [String] {
        var pausedIds: [String] = []
        self.queue.sync {
            self.pausedByInterruptionAssetIds.removeAll()
            for (assetId, assetPlayer) in self.assetPlayers {
                if assetPlayer.isPlaying {
                    let _ = assetPlayer.pause()
                    self.pausedByInterruptionAssetIds.append(assetId)
                }
            }
            pausedIds = self.pausedByInterruptionAssetIds
        }
        return pausedIds
    }

    @objc public func resumeAllAfterInterruption() -> [String] {
        var resumedIds: [String] = []
        self.queue.sync {
            for assetId in self.pausedByInterruptionAssetIds {
                if let assetPlayer = self.assetPlayers[assetId] {
                    let _ = assetPlayer.play()
                    resumedIds.append(assetId)
                }
            }
            self.pausedByInterruptionAssetIds.removeAll()
        }
        return resumedIds
    }

    /**
     * Asset
     */

    @objc public func getAssets() throws -> [String: Any] {
        var ids: [String] = []
        self.queue.sync {
            ids = Array(self.assetPlayers.keys)
        }
        return ["assets": ids]
    }

    @objc public func preloadAsset(
        _ id: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?,
        numberOfLoops: NSNumber?,
        enablePositionUpdates: NSNumber?,
        positionUpdateInterval: NSNumber?
    ) async throws -> [String: Any] {
        self.removeAssetPlayer(id)

        let url = try await resolveURL(source: source, id: id)

        let assetPlayer = try AssetPlayer(
            id,
            url: url,
            volume: volume?.floatValue ?? 1.0,
            rate: rate?.floatValue ?? 1.0,
            numberOfLoops: numberOfLoops?.intValue ?? 0,
            enablePositionUpdates: enablePositionUpdates?.boolValue ?? false,
            positionUpdateInterval: positionUpdateInterval?.doubleValue ?? 0.5,
            delegate: self
        )

        self.addAssetPlayer(id, player: assetPlayer)

        return ["id": id, "duration": assetPlayer.duration]
    }

    @objc public func unloadAsset(_ id: String) throws -> [String: Any] {
        let _ = try self.getAssetPlayer(id)

        self.removeAssetPlayer(id)
        self.cleanupTemporaryFile(for: id)
        self.manageSessionActivation(isActivating: false)

        return ["id": id]
    }

    @objc public func getAssetState(_ id: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)
        return [
            "id": id,
            "isPlaying": assetPlayer.isPlaying,
            "currentTime": assetPlayer.currentTime,
            "duration": assetPlayer.duration,
            "volume": assetPlayer.volume,
            "rate": assetPlayer.rate,
            "numberOfLoops": assetPlayer.numberOfLoops
        ]
    }

    @objc public func playAsset(_ id: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)
        self.manageSessionActivation(isActivating: true)
        return ["id": id, "isPlaying": assetPlayer.play()]
    }

    @objc public func pauseAsset(_ id: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)

        let result: [String: Any] = ["id": id, "isPlaying": assetPlayer.pause()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func stopAsset(_ id: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)

        let result: [String: Any] = ["id": id, "isPlaying": assetPlayer.stop()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func seekAsset(_ id: String, time: TimeInterval) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)
        return ["id": id, "currentTime": assetPlayer.seek(to: time)]
    }

    @objc public func setAssetVolume(_ id: String, volume: Float) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)
        assetPlayer.volume = volume
        return ["id": id, "volume": assetPlayer.volume]
    }

    @objc public func setAssetRate(_ id: String, rate: Float) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(id)
        assetPlayer.rate = rate
        return ["id": id, "rate": assetPlayer.rate]
    }

    @objc public func setAssetNumberOfLoops(_ id: String, numberOfLoops: Int) throws
        -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(id)
        assetPlayer.numberOfLoops = numberOfLoops
        return ["id": id, "numberOfLoops": assetPlayer.numberOfLoops]
    }

    @objc public func setAssetEnablePositionUpdates(_ id: String, enabled: Bool) throws
        -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(id)
        assetPlayer.enablePositionUpdates = enabled
        return [
            "id": id,
            "enablePositionUpdates": enabled,
        ]
    }

    @objc public func setAssetPositionUpdateInterval(_ id: String, interval: TimeInterval)
        throws -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(id)
        assetPlayer.positionUpdateInterval = interval
        return [
            "id": id,
            "positionUpdateInterval": interval
        ]
    }

    /**
     * Private methods
     */

    private func getAssetPlayer(_ id: String) throws -> AssetPlayer {
        var player: AssetPlayer?
        self.queue.sync {
            player = self.assetPlayers[id]
        }
        guard
            let assetPlayer = player
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return assetPlayer
    }

    private func addAssetPlayer(_ id: String, player: AssetPlayer) {
        self.queue.async(flags: .barrier) {
            self.assetPlayers[id] = player
        }
    }

    private func removeAssetPlayer(_ id: String) {
        self.queue.async(flags: .barrier) {
            if let _ = self.assetPlayers[id] {
                self.assetPlayers.removeValue(forKey: id)
            }
        }
    }

    private func manageSessionActivation(isActivating: Bool) {
        if isActivating {
            do {
                try self.audioSession.setActive(true)
            } catch {
            }
        } else {
            var allStopped = true
            self.queue.sync {
                allStopped = self.assetPlayers.values.allSatisfy { !$0.isPlaying }
            }

            if allStopped && self.enableAutoIosSessionDeactivation {
                do {
                    try self.audioSession.setActive(false)
                } catch {
                }
            }
        }
    }

    private func cleanupTemporaryFiles() {
        var ids: [String] = []
        self.queue.sync {
            ids = Array(self.temporaryFileURLs.keys)
        }

        for id in ids {
            self.cleanupTemporaryFile(for: id)
        }

        self.queue.async(flags: .barrier) {
            self.temporaryFileURLs.removeAll()
        }
    }

    private func getTemporaryFileURL(for id: String) -> URL? {
        var tempURL: URL?
        self.queue.sync {
            tempURL = self.temporaryFileURLs[id]
        }
        return tempURL
    }

    private func cleanupTemporaryFile(for id: String) {
        guard
            let url = self.getTemporaryFileURL(for: id)
        else { return }

        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs.removeValue(forKey: id)
            }
        } catch {
        }
    }

    private func resolveURL(source: String, id: String) async throws -> URL {
        let url: URL
        if source.lowercased().hasPrefix("http://") || source.lowercased().hasPrefix("https://") {
            guard
                let remoteURL = URL(string: source)
            else {
                throw NSError(
                    domain: "NativeAudio", code: -2,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                )
            }

            if let existingURL = self.getTemporaryFileURL(for: id) {
                if FileManager.default.fileExists(atPath: existingURL.path) {
                    print("Using cached temporary file for id: \(id)")
                    return existingURL
                }
            }

            let (data, _) = try await URLSession.shared.data(from: remoteURL)
            let tempDir = FileManager.default.temporaryDirectory

            // Get the file extension from the original URL
            let sourceExtension = (source as NSString).pathExtension
            let fileExtension = sourceExtension.isEmpty ? "m4a" : sourceExtension
            let tempFile = tempDir.appendingPathComponent("\(id).\(fileExtension)")

            if FileManager.default.fileExists(atPath: tempFile.path) {
                try? FileManager.default.removeItem(at: tempFile)
            }

            try data.write(to: tempFile)
            url = tempFile

            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs[id] = url
            }
        } else {
            let fileManager = FileManager.default
            let sourceWithoutExtension = (source as NSString).deletingPathExtension
            let fileExtension = (source as NSString).pathExtension

            if let path = Bundle.main.path(
                forResource: sourceWithoutExtension,
                ofType: fileExtension.isEmpty ? nil : fileExtension
            ) {
                url = URL(fileURLWithPath: path)
            } else {
                let wwwPath = Bundle.main.bundlePath + "/_capacitor_/public/" + source
                if fileManager.fileExists(atPath: wwwPath) {
                    url = URL(fileURLWithPath: wwwPath)
                } else {
                    throw NSError(
                        domain: "NativeAudio", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "File not found"]
                    )
                }
            }
        }
        return url
    }

}

extension NativeAudio: AssetEventsProtocol {
    @objc public func onAssetLoaded(_ id: String, duration: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetLoaded"),
            object: nil,
            userInfo: ["eventName": "assetLoaded", "id": id, "duration": duration]
        )
    }

    @objc public func onAssetUnloaded(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetUnloaded"),
            object: nil,
            userInfo: ["eventName": "assetUnloaded", "id": id]
        )
    }

    @objc public func onAssetStarted(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetStarted"),
            object: nil,
            userInfo: ["eventName": "assetStarted", "id": id]
        )
    }

    @objc public func onAssetPaused(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetPaused"),
            object: nil,
            userInfo: ["eventName": "assetPaused", "id": id]
        )
    }

    @objc public func onAssetStopped(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetStopped"),
            object: nil,
            userInfo: ["eventName": "assetStopped", "id": id]
        )
    }

    @objc public func onAssetSeeked(_ id: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetSeeked"),
            object: nil,
            userInfo: ["eventName": "assetSeeked", "id": id, "currentTime": currentTime]
        )
    }

    @objc public func onAssetCompleted(_ id: String) {
        self.manageSessionActivation(isActivating: false)
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetCompleted"),
            object: nil,
            userInfo: ["eventName": "assetCompleted", "id": id]
        )
    }

    @objc public func onAssetError(_ id: String, error: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetError"),
            object: nil,
            userInfo: ["eventName": "assetError", "id": id, "error": error]
        )
    }

    @objc public func onAssetPositionUpdated(_ id: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetPositionUpdate"),
            object: nil,
            userInfo: [
                "eventName": "assetPositionUpdate", "id": id, "currentTime": currentTime,
            ]
        )
    }
}

extension NativeAudio: MixerEventsProtocol {
    @objc public func onMixerLoaded(_ id: String, duration: TimeInterval) {}
    @objc public func onMixerUnloaded(_ id: String) {}
    @objc public func onMixerStarted(_ id: String) {}
    @objc public func onMixerPaused(_ id: String) {}
    @objc public func onMixerStopped(_ id: String) {}
    @objc public func onMixerSeeked(_ id: String, currentTime: TimeInterval) {}
    @objc public func onMixerCompleted(_ id: String) {}
    @objc public func onMixerError(_ id: String, error: String) {}
    @objc public func onMixerPositionUpdated(_ id: String, currentTime: TimeInterval) {}
}
