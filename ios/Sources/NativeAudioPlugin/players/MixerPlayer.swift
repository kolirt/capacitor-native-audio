import AVFoundation

@objc public class MixerPlayer: NSObject, AVAudioPlayerDelegate {
    public let id: String

    private var player: AVAudioPlayer?

    private weak var delegate: AssetEventsProtocol?

    @objc public init(
        _ id: String,
        url: URL,
        volume: Float,
        rate: Float,
        numberOfLoops: Int,
        enablePositionUpdates: Bool,
        positionUpdateInterval: TimeInterval,
        delegate: AssetEventsProtocol
    ) throws {
        self.id = id

        self.delegate = delegate

        super.init()

        self.player = try AssetPlayer(
            id,
            url: url,
            volume: volume,
            rate: rate,
            numberOfLoops: numberOfLoops,
            enablePositionUpdates: enablePositionUpdates,
            positionUpdateInterval: positionUpdateInterval,
            delegate: self
        )
    }
}

extension MixerPlayer: AssetEventsProtocol {
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
}

extension MixerPlayer: PlayerProtocol {
    @objc public var enablePositionUpdates: Bool {
        get { return self.player.enablePositionUpdates }
        set(newValue) { self.player.enablePositionUpdates = newValue }
    }

    @objc public var positionUpdateInterval: TimeInterval {
        get { return self.player.positionUpdateInterval }
        set(newValue) { self.player.positionUpdateInterval = newValue }
    }

    @objc public var isPlaying: Bool { return self.player.isPlaying }

    @objc public var currentTime: TimeInterval {
        get { return self.player.currentTime }
        set(newValue) { self.player.currentTime = newValue }
    }

    @objc public var duration: TimeInterval { return self.player.duration }

    @objc public var volume: Float {
        get { return self.player.volume }
        set(newValue) { self.player.volume = newValue }
    }

    @objc public var rate: Float {
        get { return self.player.rate }
        set(newValue) { self.player.rate = newValue }
    }

    @objc public var numberOfLoops: Int {
        get { return self.player.numberOfLoops }
        set(newValue) { self.player.numberOfLoops = newValue }
    }

    @objc public func play() -> Bool {
        let result = self.player.play()
        return result
    }
    @objc public func pause() -> Bool {
        let result = self.player.pause()
        return result
    }
    @objc public func stop() -> Bool {
        let result = self.player.stop()
        return result
    }
    @objc public func seek(to time: TimeInterval) -> TimeInterval {
        let newTime = self.player.seek(to: time)
        return newTime
    }
}
