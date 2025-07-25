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

    private var pausedByInterruptionIds: [String] = []

    public var players: [String: PlayerProtocol] = [:]

    deinit {
        URLResolver.cleanupAllTemporaryFiles()
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

    @objc public func pauseAllForInterruption() -> [String: Any] {
        var pausedIds: [String] = []
        self.queue.sync {
            self.pausedByInterruptionIds.removeAll()
            for (id, player) in self.players {
                if player.isPlaying {
                    let _ = player.pause()
                    self.pausedByInterruptionIds.append(id)
                }
            }
            pausedIds = self.pausedByInterruptionIds
        }
        return ["ids": pausedIds]
    }

    @objc public func resumeAllAfterInterruption() -> [String: Any] {
        var resumedIds: [String] = []
        self.queue.sync {
            for id in self.pausedByInterruptionIds {
                if let player = self.players[id] {
                    let _ = player.play()
                    resumedIds.append(id)
                }
            }
            self.pausedByInterruptionIds.removeAll()
        }
        return ["ids": resumedIds]
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
                allStopped = self.players.values.allSatisfy { !$0.isPlaying }
            }

            if allStopped && self.enableAutoIosSessionDeactivation {
                do {
                    try self.audioSession.setActive(false)
                } catch {
                }
            }
        }
    }
}

extension NativeAudio: NativeAudioPlayerMethodsProtocol {
    @objc public func getPlayers() throws -> [String: Any] {
        var ids: [String] = []
        self.queue.sync {
            ids = Array(self.players.keys)
        }
        return ["ids": ids]
    }

    @objc public func preload(
        _ type: String,
        _ id: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?,
        numberOfLoops: NSNumber?,
        enablePositionUpdates: NSNumber?,
        positionUpdateInterval: NSNumber?
    ) async throws -> [String: Any] {
        self.removePlayer(id)

        let url = try await URLResolver.resolveURL(source: source, id: id)

        var player: PlayerProtocol

        let volume = volume?.floatValue ?? 1.0
        let rate = rate?.floatValue ?? 1.0
        let numberOfLoops = numberOfLoops?.intValue ?? 0
        let enablePositionUpdates = enablePositionUpdates?.boolValue ?? false
        let positionUpdateInterval = positionUpdateInterval?.doubleValue ?? 0.5

        switch type {
        case "asset":
            player = try AssetPlayer(
                id,
                url: url,
                volume: volume,
                rate: rate,
                numberOfLoops: numberOfLoops,
                enablePositionUpdates: enablePositionUpdates,
                positionUpdateInterval: positionUpdateInterval,
                delegate: self
            )
        case "mixer":
            player = try MixerPlayer(
                id,
                url: url,
                volume: volume,
                rate: rate,
                numberOfLoops: numberOfLoops,
                enablePositionUpdates: enablePositionUpdates,
                positionUpdateInterval: positionUpdateInterval,
                delegate: self
            )
        default:
            throw NSError(
                domain: "NativeAudio", code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid type: \(type)"]
            )
        }

        self.addPlayer(id, player: player)

        return ["id": id, "duration": player.duration]
    }

    @objc public func preloadMixerBackground(
        _ mixerId: String,
        _ id: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?
    ) async throws -> [String: Any] {
        guard
            let mixer = try self.getPlayer(mixerId) as? MixerPlayer
        else {
            throw NSError(
                domain: "NativeAudio", code: -7,
                userInfo: [NSLocalizedDescriptionKey: "Player is not a mixer"]
            )
        }

        let url = try await URLResolver.resolveURL(source: source, id: mixerId + "_" + id)
        let volume = volume?.floatValue ?? 1.0
        let rate = rate?.floatValue ?? 1.0

        let result = try await mixer.preloadBackground(
            id,
            url: url,
            volume: volume,
            rate: rate
        )

        return result
    }

    @objc public func unload(_ id: String) throws -> [String: Any] {
        let _ = try self.getPlayer(id)

        self.removePlayer(id)
        URLResolver.cleanupTemporaryFile(for: id)
        self.manageSessionActivation(isActivating: false)

        return ["id": id]
    }

    @objc public func unloadMixerBackground(_ mixerId: String, _ id: String) throws -> [String: Any]
    {
        guard
            let mixer = try self.getPlayer(mixerId) as? MixerPlayer
        else {
            throw NSError(
                domain: "NativeAudio", code: -7,
                userInfo: [NSLocalizedDescriptionKey: "Player is not a mixer"]
            )
        }

        let result = try mixer.unloadBackground(id)

        return result
    }

    @objc public func getState(_ id: String) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        return player.state
    }

    @objc public func play(_ id: String) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        self.manageSessionActivation(isActivating: true)
        return ["id": id, "isPlaying": player.play()]
    }

    @objc public func pause(_ id: String) throws -> [String: Any] {
        let player = try self.getPlayer(id)

        let result: [String: Any] = ["id": id, "isPlaying": player.pause()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func stop(_ id: String) throws -> [String: Any] {
        let player = try self.getPlayer(id)

        let result: [String: Any] = ["id": id, "isPlaying": player.stop()]

        self.manageSessionActivation(isActivating: false)

        return result
    }

    @objc public func seek(_ id: String, time: TimeInterval) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        return ["id": id, "currentTime": player.seek(to: time)]
    }

    @objc public func setVolume(_ id: String, volume: Float) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        player.volume = volume
        return ["id": id, "volume": player.volume]
    }

    @objc public func setRate(_ id: String, rate: Float) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        player.rate = rate
        return ["id": id, "rate": player.rate]
    }

    @objc public func setNumberOfLoops(
        _ id: String,
        numberOfLoops: Int
    ) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        player.numberOfLoops = numberOfLoops
        return ["id": id, "numberOfLoops": player.numberOfLoops]
    }

    @objc public func setEnablePositionUpdates(
        _ id: String,
        enabled: Bool
    ) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        player.enablePositionUpdates = enabled
        return [
            "id": id,
            "enablePositionUpdates": enabled,
        ]
    }

    @objc public func setPositionUpdateInterval(
        _ id: String,
        interval: TimeInterval
    ) throws -> [String: Any] {
        let player = try self.getPlayer(id)
        player.positionUpdateInterval = interval
        return [
            "id": id,
            "positionUpdateInterval": interval,
        ]
    }

    @objc public func getPlayer(_ id: String) throws -> PlayerProtocol {
        var player: PlayerProtocol?
        self.queue.sync {
            player = self.players[id]
        }
        guard
            let playerInstance = player
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Player not found"]
            )
        }
        return playerInstance
    }

    @objc public func addPlayer(_ id: String, player: PlayerProtocol) {
        self.queue.async(flags: .barrier) {
            self.players[id] = player
        }
    }

    @objc public func removePlayer(_ id: String) {
        self.queue.async(flags: .barrier) {
            if let _ = self.players[id] {
                self.players.removeValue(forKey: id)
            }
        }
    }
}

extension NativeAudio: PlayerEventsProtocol {
    @objc public func onPlayerLoaded(_ id: String, duration: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerLoaded"),
            object: nil,
            userInfo: ["eventName": "playerLoaded", "id": id, "duration": duration]
        )
    }

    @objc public func onPlayerUnloaded(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerUnloaded"),
            object: nil,
            userInfo: ["eventName": "playerUnloaded", "id": id]
        )
    }

    @objc public func onPlayerStarted(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerStarted"),
            object: nil,
            userInfo: ["eventName": "playerStarted", "id": id]
        )
    }

    @objc public func onPlayerPaused(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerPaused"),
            object: nil,
            userInfo: ["eventName": "playerPaused", "id": id]
        )
    }

    @objc public func onPlayerStopped(_ id: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerStopped"),
            object: nil,
            userInfo: ["eventName": "playerStopped", "id": id]
        )
    }

    @objc public func onPlayerSeeked(_ id: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerSeeked"),
            object: nil,
            userInfo: ["eventName": "playerSeeked", "id": id, "currentTime": currentTime]
        )
    }

    @objc public func onPlayerCompleted(_ id: String) {
        self.manageSessionActivation(isActivating: false)
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerCompleted"),
            object: nil,
            userInfo: ["eventName": "playerCompleted", "id": id]
        )
    }

    @objc public func onPlayerError(_ id: String, error: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerError"),
            object: nil,
            userInfo: ["eventName": "playerError", "id": id, "error": error]
        )
    }

    @objc public func onPlayerPositionUpdated(_ id: String, currentTime: TimeInterval) {
        NotificationCenter.default.post(
            name: NSNotification.Name("NativeAudioPlayerPositionUpdated"),
            object: nil,
            userInfo: [
                "eventName": "playerPositionUpdated", "id": id, "currentTime": currentTime,
            ]
        )
    }

    @objc public func onMixerBackgroundLoaded(
        _ mixerId: String,
        _ backgroundId: String,
        duration: TimeInterval
    ) {}
    @objc public func onMixerBackgroundUnloaded(_ mixerId: String, _ backgroundId: String) {}
}
