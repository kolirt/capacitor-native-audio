import Foundation
import AVFoundation

@objc public class NativeAudio: NSObject {
    private var enableAutoInterruptionHandling = true
    private var enableAutoIosSessionActivation = false
    private var positionUpdateInterval: TimeInterval = 0.25

    private var assetPlayers: [String: AssetPlayer] = [:]
    private var pausedByInterruptionAssetIds: [String] = []
    private var temporaryFileURLs: [String: URL] = [:]

    deinit {
        cleanupTemporaryFiles()
    }

    @objc public func configureSession(
        enableAutoInterruptionHandling: Bool,
        enableAutoIosSessionActivation: Bool,
        positionUpdateInterval: TimeInterval?,
        iosCategory: String?,
        iosMode: String?,
        iosOptions: [String]?
    ) throws -> [String: Any] {
        self.enableAutoInterruptionHandling = enableAutoInterruptionHandling
        self.enableAutoIosSessionActivation = enableAutoIosSessionActivation

        if let interval = positionUpdateInterval {
            self.positionUpdateInterval = max(0.1, min(2.0, interval))
        }

        let audioSession = AVAudioSession.sharedInstance()

        let categoryStr = iosCategory ?? "ambient"
        guard
            let avCategory = AVAudioSession.Category(rawValue: categoryStr)
        else {
            throw NSError(
                domain: "NativeAudio", code: -4,
                userInfo: [NSLocalizedDescriptionKey: "Invalid iOS category"]
            )
        }

        let modeStr = iosMode ?? "default"
        guard
            let avMode = AVAudioSession.Mode(rawValue: modeStr)
        else {
            throw NSError(
                domain: "NativeAudio", code: -5,
                userInfo: [NSLocalizedDescriptionKey: "Invalid iOS mode"]
            )
        }

        var avOptions: AVAudioSession.CategoryOptions = []
        if let options = iosOptions {
            for option in options {
                switch option {
                case "mixWithOthers": avOptions.insert(.mixWithOthers)
                case "duckOthers": avOptions.insert(.duckOthers)
                case "interruptSpokenAudioAndMixWithOthers":
                    avOptions.insert(.interruptSpokenAudioAndMixWithOthers)
                case "allowBluetoothA2DP": avOptions.insert(.allowBluetoothA2DP)
                case "allowAirPlay": avOptions.insert(.allowAirPlay)
                case "defaultToSpeaker": avOptions.insert(.defaultToSpeaker)
                case "overrideMutedMicrophoneInterruption":
                    avOptions.insert(.overrideMutedMicrophoneInterruption)
                default:
                    throw NSError(
                        domain: "NativeAudio", code: -6,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid iOS option: \(option)"]
                    )
                }
            }
        }

        try audioSession.setCategory(avCategory, mode: avMode, options: avOptions)

        return [
            "enableAutoInterruptionHandling": self.enableAutoInterruptionHandling,
            "enableAutoIosSessionActivation": self.enableAutoIosSessionActivation,
            "positionUpdateInterval": self.positionUpdateInterval,
            "iosCategory": categoryStr,
            "iosMode": modeStr,
            "iosOptions": iosOptions ?? [],
        ]
    }

    @objc public func pauseAllAssetsForInterruption() -> [String] {
        self.pausedByInterruptionAssetIds.removeAll()
        for (assetId, assetPlayer) in assetPlayers {
            if assetPlayer.isPlaying {
                assetPlayer.pause()
                self.pausedByInterruptionAssetIds.append(assetId)
            }
        }
        return self.pausedByInterruptionAssetIds
    }

    @objc public func resumeAllAssetsAfterInterruption() -> [String] {
        var resumedIds: [String] = []
        for assetId in self.pausedByInterruptionAssetIds {
            if let assetPlayer = assetPlayers[assetId] {
                assetPlayer.play()
                resumedIds.append(assetId)
            }
        }
        self.pausedByInterruptionAssetIds.removeAll()
        return resumedIds
    }

    /**
     * Asset
     */

    @objc public func getAssets() throws -> [String: Any] {
        let assetIds = Array(self.assetPlayers.keys)
        return ["assets": assetIds]
    }

    @objc public func preloadAsset(
        _ assetId: String,
        source: String,
        volume: Float,
        rate: Float,
        numberOfLoops: Int
    ) async throws -> [String: Any] {
        self.assetPlayers.removeValue(forKey: assetId)

        let url = try await resolveURL(source: source, assetId: assetId)

        let assetPlayer = try AssetPlayer(
            assetId,
            url: url,
            volume: volume,
            rate: rate,
            numberOfLoops: numberOfLoops,
            updateInterval: self.positionUpdateInterval,
            delegate: self
        )
        self.assetPlayers[assetId] = assetPlayer

        return ["assetId": assetId, "duration": assetPlayer.duration]
    }

    @objc public func unloadAsset(_ assetId: String) throws -> [String: Any] {
        guard
            let _ = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        self.assetPlayers.removeValue(forKey: assetId)

        if let tempURL = self.temporaryFileURLs[assetId] {
            do {
                try FileManager.default.removeItem(at: tempURL)
                print("Removed temporary file for assetId: \(assetId)")
            } catch {
                print("Failed to remove temporary file: \(error.localizedDescription)")
            }
            self.temporaryFileURLs.removeValue(forKey: assetId)
        }

        self.manageSessionActivation(isActivating: false)
        return ["assetId": assetId]
    }

    @objc public func getAssetState(_ assetId: String) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return [
            "assetId": assetId,
            "isPlaying": assetPlayer.isPlaying,
            "currentTime": assetPlayer.currentTime,
            "duration": assetPlayer.duration,
        ]
    }

    @objc public func playAsset(_ assetId: String) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }

        self.manageSessionActivation(isActivating: true)

        return ["assetId": assetId, "isPlaying": assetPlayer.play()]
    }

    @objc public func resumeAsset(_ assetId: String) throws -> [String: Any] {
        return try playAsset(assetId)
    }

    @objc public func pauseAsset(_ assetId: String) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }

        let result = ["assetId": assetId, "isPlaying": assetPlayer.pause()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func stopAsset(_ assetId: String) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }

        let result = ["assetId": assetId, "isPlaying": assetPlayer.stop()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func seekAsset(_ assetId: String, time: TimeInterval) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return ["assetId": assetId, "currentTime": assetPlayer.seek(to: time)]
    }

    @objc public func setAssetVolume(_ assetId: String, volume: Float) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return ["assetId": assetId, "volume": assetPlayer.setVolume(volume)]
    }

    @objc public func setAssetRate(_ assetId: String, rate: Float) throws -> [String: Any] {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return ["assetId": assetId, "rate": assetPlayer.setRate(rate)]
    }

    @objc public func setAssetNumberOfLoops(_ assetId: String, numberOfLoops: Int) throws
        -> [String: Any]
    {
        guard
            let assetPlayer = self.assetPlayers[assetId]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return ["assetId": assetId, "numberOfLoops": assetPlayer.setNumberOfLoops(numberOfLoops)]
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

    private func manageSessionActivation(isActivating: Bool) {
        let audioSession = AVAudioSession.sharedInstance()

        if isActivating {
            print("manageSessionActivation: Attempting to activate session")

            if self.enableAutoIosSessionActivation {
                do {
                    try audioSession.setActive(true)
                    print("manageSessionActivation: Audio session activated successfully")
                } catch {
                    print(
                        "manageSessionActivation: Failed to activate audio session: \(error.localizedDescription)"
                    )
                }
            } else {
                print(
                    "manageSessionActivation: Auto activation disabled, skipping session activation"
                )
            }
        } else {
            print("manageSessionActivation: Attempting to deactivate session")
            let allStopped = assetPlayers.values.allSatisfy { !$0.isPlaying }
            print("manageSessionActivation: All players stopped: \(allStopped)")

            if allStopped && !self.enableAutoIosSessionActivation {
                do {
                    try audioSession.setActive(false)
                    print("manageSessionActivation: Audio session deactivated successfully")
                } catch {
                    print(
                        "manageSessionActivation: Failed to deactivate audio session: \(error.localizedDescription)"
                    )
                }
            } else {
                if !allStopped {
                    print(
                        "manageSessionActivation: Not all players stopped, keeping session active")
                }
                if self.enableAutoIosSessionActivation {
                    print(
                        "manageSessionActivation: Auto activation enabled, not deactivating session"
                    )
                }
            }
        }
    }

    private func cleanupTemporaryFiles() {
        for (assetId, url) in self.temporaryFileURLs {
            do {
                try FileManager.default.removeItem(at: url)
                print("Cleaned up temporary file for assetId: \(assetId)")
            } catch {
                print("Failed to clean up temporary file: \(error.localizedDescription)")
            }
        }
        self.temporaryFileURLs.removeAll()
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

            if let existingURL = self.temporaryFileURLs[assetId] {
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

            try data.write(to: tempFile)
            url = tempFile

            self.temporaryFileURLs[assetId] = url
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
