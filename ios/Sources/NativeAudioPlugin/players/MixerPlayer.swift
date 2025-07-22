import AVFoundation

@objc public class MixerPlayer: NSObject, AVAudioPlayerDelegate {
    public let id: String

    public var player: AssetPlayer?
    public var backgroundPlayers: [String: AssetPlayer] = [:]

    private weak var delegate: PlayerEventsProtocol?

    @objc public init(
        _ id: String,
        url: URL,
        volume: Float,
        rate: Float,
        numberOfLoops: Int,
        enablePositionUpdates: Bool,
        positionUpdateInterval: TimeInterval,
        delegate: PlayerEventsProtocol
    ) throws {
        self.id = id

        self.delegate = delegate

        super.init()

        self.player = try AssetPlayer(
            id + "_main",
            url: url,
            volume: volume,
            rate: rate,
            numberOfLoops: numberOfLoops,
            enablePositionUpdates: enablePositionUpdates,
            positionUpdateInterval: positionUpdateInterval,
            delegate: self
        )

        self.delegate?.onMixerLoaded(self.id, duration: self.duration)
    }

    deinit {
        let _ = self.player?.stop()
        for (_, backgroundPlayer) in self.backgroundPlayers {
            let _ = backgroundPlayer.stop()
        }
        self.delegate?.onMixerUnloaded(self.id)
    }
}

extension MixerPlayer: PlayerEventsProtocol {
    @objc public func onAssetLoaded(_ assetId: String, duration: TimeInterval) {
        self.delegate?.onAssetLoaded(self.id, duration: duration)
    }
    @objc public func onAssetUnloaded(_ assetId: String) {
        self.delegate?.onAssetUnloaded(self.id)
    }
    @objc public func onAssetStarted(_ assetId: String) {
        self.delegate?.onAssetStarted(self.id)
    }
    @objc public func onAssetPaused(_ assetId: String) {
        self.delegate?.onAssetPaused(self.id)
    }
    @objc public func onAssetStopped(_ assetId: String) {
        self.delegate?.onAssetStopped(self.id)
    }
    @objc public func onAssetSeeked(_ assetId: String, currentTime: TimeInterval) {
        self.delegate?.onAssetSeeked(self.id, currentTime: currentTime)
    }
    @objc public func onAssetCompleted(_ assetId: String) {
        self.delegate?.onAssetCompleted(self.id)
    }
    @objc public func onAssetError(_ assetId: String, error: String) {
        self.delegate?.onAssetError(self.id, error: error)
    }
    @objc public func onAssetPositionUpdated(_ assetId: String, currentTime: TimeInterval) {
        self.delegate?.onAssetPositionUpdated(self.id, currentTime: currentTime)
    }

    @objc public func onMixerLoaded(_ id: String, duration: TimeInterval) {}
    @objc public func onMixerUnloaded(_ id: String) {}
    @objc public func onMixerStarted(_ id: String) {}
    @objc public func onMixerPaused(_ id: String) {}
    @objc public func onMixerStopped(_ id: String) {}
    @objc public func onMixerSeeked(_ id: String, currentTime: TimeInterval) {}
    @objc public func onMixerCompleted(_ id: String) {}
    @objc public func onMixerError(_ id: String, error: String) {}
    @objc public func onMixerPositionUpdated(_ id: String, currentTime: TimeInterval) {}

    @objc public func onMixerBackgroundLoaded(
        _ mixerId: String, _ backgroundId: String, duration: TimeInterval
    ) {}
    @objc public func onMixerBackgroundUnloaded(_ mixerId: String, _ backgroundId: String) {}
}

extension MixerPlayer: PlayerProtocol {
    @objc public var enablePositionUpdates: Bool {
        get { return self.player?.enablePositionUpdates ?? false }
        set(newValue) { self.player?.enablePositionUpdates = newValue }
    }

    @objc public var positionUpdateInterval: TimeInterval {
        get { return self.player?.positionUpdateInterval ?? 0.5 }
        set(newValue) { self.player?.positionUpdateInterval = newValue }
    }

    @objc public var isPlaying: Bool { return self.player?.isPlaying ?? false }

    @objc public var currentTime: TimeInterval {
        get { return self.player?.currentTime ?? 0 }
        set(newValue) { self.player?.currentTime = newValue }
    }

    @objc public var duration: TimeInterval { return self.player?.duration ?? 0 }

    @objc public var volume: Float {
        get { return self.player?.volume ?? 1 }
        set(newValue) { self.player?.volume = newValue }
    }

    @objc public var rate: Float {
        get { return self.player?.rate ?? 1 }
        set(newValue) { self.player?.rate = newValue }
    }

    @objc public var numberOfLoops: Int {
        get { return self.player?.numberOfLoops ?? 0 }
        set(newValue) { self.player?.numberOfLoops = newValue }
    }

    @objc public func play() -> Bool {
        return self.player?.play() ?? false
    }

    @objc public func pause() -> Bool {
        return self.player?.pause() ?? false
    }

    @objc public func stop() -> Bool {
        return self.player?.stop() ?? false
    }

    @objc public func seek(to time: TimeInterval) -> TimeInterval {
        return self.player?.seek(to: time) ?? 0
    }
}

extension MixerPlayer: MixerPlayerProtocol {
    @objc public func preloadBackground(
        _ id: String,
        url: URL,
        volume: Float
    ) async throws -> [String: Any] {
        self.removeBackgroundPlayer(id)

        let bgPlayer = try AssetPlayer(
            self.id + "_" + id,
            url: url,
            volume: volume,
            rate: rate,
            numberOfLoops: -1,
            enablePositionUpdates: false,
            positionUpdateInterval: 0.5,
            delegate: self
        )

        self.addBackgroundPlayer(id, player: bgPlayer)

        return ["id": id, "duration": 1]
    }

    @objc public func unloadBackground(_ id: String)
        throws -> [String: Any]
    {
        return ["id": id]
    }

    @objc public func getBackgroundPlayer(_ id: String) throws -> AssetPlayer {
        guard
            let backgroundPlayer = self.backgroundPlayers[id]
        else {
            throw NSError(
                domain: "NativeAudio", code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Asset not found"]
            )
        }
        return backgroundPlayer
    }

    @objc public func addBackgroundPlayer(_ id: String, player: AssetPlayer) {
        self.backgroundPlayers[id] = player
    }

    @objc public func removeBackgroundPlayer(_ id: String) {
        if let _ = self.backgroundPlayers[id] {
            self.backgroundPlayers.removeValue(forKey: id)
        }
    }
}
