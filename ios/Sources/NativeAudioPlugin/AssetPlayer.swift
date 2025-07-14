import AVFoundation

@objc public class AssetPlayer: NSObject, AVAudioPlayerDelegate {
    private let player: AVAudioPlayer
    private let assetId: String
    private let updateInterval: TimeInterval
    private weak var delegate: NativeAudio?
    private var timer: Timer?

    @objc public init(
        _ assetId: String,
        url: URL,
        volume: Float,
        rate: Float,
        numberOfLoops: Int = 0,
        updateInterval: TimeInterval = 0.25,
        delegate: NativeAudio
    ) throws {
        self.player = try AVAudioPlayer(contentsOf: url)
        self.assetId = assetId
        self.updateInterval = updateInterval
        self.delegate = delegate

        super.init()

        self.player.enableRate = true
        self.player.volume = max(0.0, min(1.0, volume))
        self.player.rate = max(0.5, min(2.0, rate))
        self.player.numberOfLoops = numberOfLoops
        self.player.prepareToPlay()

        self.delegate?.onAssetLoaded(assetId, duration: self.player.duration)
    }

    deinit {
        self.player.stop()
        self.stopPositionUpdates()
        self.delegate?.onAssetUnloaded(self.assetId)
    }

    @objc public var isPlaying: Bool {
        return self.player.isPlaying
    }

    @objc public var currentTime: TimeInterval {
        return self.player.currentTime
    }

    @objc public var duration: TimeInterval {
        return self.player.duration
    }

    @objc public func play() -> Bool {
        if !self.isPlaying {

            if self.player.play() {
                self.startPositionUpdates()
                self.delegate?.onAssetStarted(self.assetId)
            }
        }

        return self.isPlaying
    }

    @objc public func pause() -> Bool {
        if self.isPlaying {
            self.player.pause()
            self.stopPositionUpdates()
            self.delegate?.onAssetPaused(self.assetId)
        }

        return self.isPlaying
    }

    @objc public func stop() -> Bool {
        if self.isPlaying {
            self.player.stop()
            self.player.currentTime = 0
            self.stopPositionUpdates()
            self.delegate?.onAssetStopped(self.assetId)
        } else {
            self.player.currentTime = 0
        }

        return self.isPlaying
    }

    @objc public func seek(to time: TimeInterval) -> TimeInterval {
        self.player.currentTime = max(0, min(time, self.player.duration))
        self.delegate?.onAssetSeeked(self.assetId, currentTime: self.currentTime)
        return self.currentTime
    }

    @objc public func setVolume(_ volume: Float) -> Float {
        self.player.volume = max(0.0, min(1.0, volume))
        return self.player.volume
    }

    @objc public func setRate(_ rate: Float) -> Float {
        self.player.rate = max(0.5, min(2.0, rate))
        return self.player.rate
    }

    @objc public func setNumberOfLoops(_ numberOfLoops: Int = 0) -> Int {
        self.player.numberOfLoops = numberOfLoops
        return self.player.numberOfLoops
    }

    private func startPositionUpdates() {
        self.timer?.invalidate()
        DispatchQueue.main.async { [weak self] in
            guard
                let self = self
            else { return }
            self.timer = Timer.scheduledTimer(withTimeInterval: self.updateInterval, repeats: true)
            {
                [weak self] _ in
                guard
                    let self = self,
                    self.isPlaying
                else { return }
                self.delegate?.onAssetPositionUpdated(self.assetId, currentTime: self.currentTime)
            }
        }
    }

    private func stopPositionUpdates() {
        self.timer?.invalidate()
        self.timer = nil
    }

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopPositionUpdates()

        if flag {
            self.delegate?.onAssetCompleted(self.assetId)
        }
    }

    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        self.stopPositionUpdates()
        self.delegate?.onAssetError(
            self.assetId,
            error: error?.localizedDescription ?? "Unknown error"
        )
    }
}
