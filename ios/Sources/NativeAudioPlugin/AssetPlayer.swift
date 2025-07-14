import AVFoundation

@objc public class AssetPlayer: NSObject, AVAudioPlayerDelegate {
    private let player: AVAudioPlayer
    private let assetId: String
    private var enablePositionUpdates: Bool
    private var positionUpdateInterval: TimeInterval
    private weak var delegate: NativeAudio?
    private var timer: DispatchSourceTimer?

    @objc public init(
        _ assetId: String,
        url: URL,
        volume: Float,
        rate: Float,
        numberOfLoops: Int,
        enablePositionUpdates: Bool,
        positionUpdateInterval: TimeInterval,
        delegate: NativeAudio
    ) throws {
        self.player = try AVAudioPlayer(contentsOf: url)
        self.assetId = assetId
        self.enablePositionUpdates = enablePositionUpdates
        self.positionUpdateInterval = max(0.1, min(2.0, positionUpdateInterval))
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
        self.delegate = nil
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
            self.stopPositionUpdates()
        }
        self.delegate?.onAssetStopped(self.assetId)
        self.player.currentTime = 0

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

    @objc public func setEnablePositionUpdates(_ enabled: Bool) -> Bool {
        let oldValue = self.enablePositionUpdates
        self.enablePositionUpdates = enabled

        if enabled && !oldValue {
            if self.isPlaying {
                self.startPositionUpdates()
            }
        } else if !enabled && oldValue {
            self.stopPositionUpdates()
        }

        return enabled
    }

    @objc public func setPositionUpdateInterval(_ interval: TimeInterval) -> TimeInterval {
        let clampedInterval = max(0.1, min(2.0, interval))
        self.positionUpdateInterval = clampedInterval

        if self.enablePositionUpdates && self.isPlaying {
            self.stopPositionUpdates()
            self.startPositionUpdates()
        }

        return clampedInterval
    }

    private func startPositionUpdates() {
        self.timer?.cancel()
        self.timer = nil

        guard self.enablePositionUpdates else { return }

        let queue = DispatchQueue.global(qos: .background)
        self.timer = DispatchSource.makeTimerSource(queue: queue)

        self.timer?.schedule(
            deadline: .now(),
            repeating: .milliseconds(Int(self.positionUpdateInterval * 1000))
        )

        self.timer?.setEventHandler { [weak self] in
            guard let self = self, self.isPlaying else { return }
            DispatchQueue.main.async {
                self.delegate?.onAssetPositionUpdated(self.assetId, currentTime: self.currentTime)
            }
        }

        self.timer?.resume()
    }

    private func stopPositionUpdates() {
        self.timer?.cancel()
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
