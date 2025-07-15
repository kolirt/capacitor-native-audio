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
            return queue.sync {
                return self._enableAutoInterruptionHandling
            }
        }
        set(newValue) {
            queue.async(flags: .barrier) {
                self._enableAutoInterruptionHandling = newValue
            }
        }
    }

    public var enableAutoIosSessionDeactivation: Bool {
        get {
            return queue.sync {
                return self._enableAutoIosSessionDeactivation
            }
        }
        set(newValue) {
            queue.async(flags: .barrier) {
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

    @objc public func pauseAllAssetsForInterruption() -> [String] {
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

    @objc public func resumeAllAssetsAfterInterruption() -> [String] {
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
        var assetIds: [String] = []
        self.queue.sync {
            assetIds = Array(self.assetPlayers.keys)
        }
        return ["assets": assetIds]
    }

    @objc public func preloadAsset(
        _ assetId: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?,
        numberOfLoops: NSNumber?,
        enablePositionUpdates: NSNumber?,
        positionUpdateInterval: NSNumber?
    ) async throws -> [String: Any] {
        self.removeAssetPlayer(assetId)

        let url = try await resolveURL(source: source, assetId: assetId)

        let assetPlayer = try AssetPlayer(
            assetId,
            url: url,
            volume: volume?.floatValue ?? 1.0,
            rate: rate?.floatValue ?? 1.0,
            numberOfLoops: numberOfLoops?.intValue ?? 0,
            enablePositionUpdates: enablePositionUpdates?.boolValue ?? false,
            positionUpdateInterval: positionUpdateInterval?.doubleValue ?? 0.5,
            delegate: self
        )

        self.addAssetPlayer(assetId, player: assetPlayer)

        return ["assetId": assetId, "duration": assetPlayer.duration]
    }

    @objc public func unloadAsset(_ assetId: String) throws -> [String: Any] {
        let _ = try self.getAssetPlayer(assetId)

        self.removeAssetPlayer(assetId)
        self.cleanupTemporaryFile(for: assetId)
        self.manageSessionActivation(isActivating: false)

        return ["assetId": assetId]
    }

    @objc public func getAssetState(_ assetId: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return [
            "assetId": assetId,
            "isPlaying": assetPlayer.isPlaying,
            "currentTime": assetPlayer.currentTime,
            "duration": assetPlayer.duration,
        ]
    }

    @objc public func playAsset(_ assetId: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)
        self.manageSessionActivation(isActivating: true)
        return ["assetId": assetId, "isPlaying": assetPlayer.play()]
    }

    @objc public func pauseAsset(_ assetId: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)

        let result: [String: Any] = ["assetId": assetId, "isPlaying": assetPlayer.pause()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func stopAsset(_ assetId: String) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)

        let result: [String: Any] = ["assetId": assetId, "isPlaying": assetPlayer.stop()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func seekAsset(_ assetId: String, time: TimeInterval) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return ["assetId": assetId, "currentTime": assetPlayer.seek(to: time)]
    }

    @objc public func setAssetVolume(_ assetId: String, volume: Float) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return ["assetId": assetId, "volume": assetPlayer.setVolume(volume)]
    }

    @objc public func setAssetRate(_ assetId: String, rate: Float) throws -> [String: Any] {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return ["assetId": assetId, "rate": assetPlayer.setRate(rate)]
    }

    @objc public func setAssetNumberOfLoops(_ assetId: String, numberOfLoops: Int) throws
        -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return ["assetId": assetId, "numberOfLoops": assetPlayer.setNumberOfLoops(numberOfLoops)]
    }

    @objc public func setAssetEnablePositionUpdates(_ assetId: String, enabled: Bool) throws
        -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return [
            "assetId": assetId,
            "enablePositionUpdates": assetPlayer.setEnablePositionUpdates(enabled),
        ]
    }

    @objc public func setAssetPositionUpdateInterval(_ assetId: String, interval: TimeInterval)
        throws -> [String: Any]
    {
        let assetPlayer = try self.getAssetPlayer(assetId)
        return [
            "assetId": assetId,
            "positionUpdateInterval": assetPlayer.setPositionUpdateInterval(interval),
        ]
    }

    /**
     * Events
     */

    @objc public func onAssetLoaded(_ assetId: String, duration: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetLoaded"),
            object: nil,
            userInfo: ["eventName": "assetLoaded", "assetId": assetId, "duration": duration]
        )
    }

    @objc public func onAssetUnloaded(_ assetId: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetUnloaded"),
            object: nil,
            userInfo: ["eventName": "assetUnloaded", "assetId": assetId]
        )
    }

    @objc public func onAssetStarted(_ assetId: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetStarted"),
            object: nil,
            userInfo: ["eventName": "assetStarted", "assetId": assetId]
        )
    }

    @objc public func onAssetPaused(_ assetId: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetPaused"),
            object: nil,
            userInfo: ["eventName": "assetPaused", "assetId": assetId]
        )
    }

    @objc public func onAssetStopped(_ assetId: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetStopped"),
            object: nil,
            userInfo: ["eventName": "assetStopped", "assetId": assetId]
        )
    }

    @objc public func onAssetSeeked(_ assetId: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetSeeked"),
            object: nil,
            userInfo: ["eventName": "assetSeeked", "assetId": assetId, "currentTime": currentTime]
        )
    }

    @objc public func onAssetCompleted(_ assetId: String) {
        self.manageSessionActivation(isActivating: false)
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetCompleted"),
            object: nil,
            userInfo: ["eventName": "assetCompleted", "assetId": assetId]
        )
    }

    @objc public func onAssetError(_ assetId: String, error: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetError"),
            object: nil,
            userInfo: ["eventName": "assetError", "assetId": assetId, "error": error]
        )
    }

    @objc public func onAssetPositionUpdated(_ assetId: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioAssetPositionUpdate"),
            object: nil,
            userInfo: [
                "eventName": "assetPositionUpdate", "assetId": assetId, "currentTime": currentTime,
            ]
        )
    }

    /**
     * Private methods
     */

    private func getAssetPlayer(_ assetId: String) throws -> AssetPlayer {
        var player: AssetPlayer?
        self.queue.sync {
            player = self.assetPlayers[assetId]
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

    private func addAssetPlayer(_ assetId: String, player: AssetPlayer) {
        self.queue.async(flags: .barrier) {
            self.assetPlayers[assetId] = player
        }
    }

    private func removeAssetPlayer(_ assetId: String) {
        self.queue.async(flags: .barrier) {
            if let _ = self.assetPlayers[assetId] {
                self.assetPlayers.removeValue(forKey: assetId)
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
        var assetIds: [String] = []
        self.queue.sync {
            assetIds = Array(self.temporaryFileURLs.keys)
        }

        for assetId in assetIds {
            self.cleanupTemporaryFile(for: assetId)
        }

        self.queue.async(flags: .barrier) {
            self.temporaryFileURLs.removeAll()
        }
    }

    private func getTemporaryFileURL(for assetId: String) -> URL? {
        var tempURL: URL?
        self.queue.sync {
            tempURL = self.temporaryFileURLs[assetId]
        }
        return tempURL
    }

    private func cleanupTemporaryFile(for assetId: String) {
        guard
            let url = self.getTemporaryFileURL(for: assetId)
        else { return }

        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs.removeValue(forKey: assetId)
            }
        } catch {
        }
    }

    private func resolveURL(source: String, assetId: String) async throws -> URL {
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

            if let existingURL = self.getTemporaryFileURL(for: assetId) {
                if FileManager.default.fileExists(atPath: existingURL.path) {
                    print("Using cached temporary file for assetId: \(assetId)")
                    return existingURL
                }
            }

            let (data, _) = try await URLSession.shared.data(from: remoteURL)
            let tempDir = FileManager.default.temporaryDirectory

            // Get the file extension from the original URL
            let sourceExtension = (source as NSString).pathExtension
            let fileExtension = sourceExtension.isEmpty ? "m4a" : sourceExtension
            let tempFile = tempDir.appendingPathComponent("\(assetId).\(fileExtension)")

            if FileManager.default.fileExists(atPath: tempFile.path) {
                try? FileManager.default.removeItem(at: tempFile)
            }

            try data.write(to: tempFile)
            url = tempFile

            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs[assetId] = url
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
