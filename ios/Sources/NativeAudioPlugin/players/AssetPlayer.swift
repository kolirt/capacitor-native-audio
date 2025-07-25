import AVFoundation

@objc public class AssetPlayer: NSObject, AVAudioPlayerDelegate {
    public let id: String

    private var _enablePositionUpdates: Bool
    private var _positionUpdateInterval: TimeInterval

    private let player: AVAudioPlayer

    private weak var delegate: PlayerEventsProtocol?
    private var timer: DispatchSourceTimer?

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
        self.player = try AVAudioPlayer(contentsOf: url)

        self._enablePositionUpdates = enablePositionUpdates
        self._positionUpdateInterval = max(0.1, min(2.0, positionUpdateInterval))

        self.delegate = delegate

        super.init()

        self.player.enableRate = true
        self.player.volume = max(0.0, min(1.0, volume))
        self.player.rate = max(0.5, min(2.0, rate))
        self.player.numberOfLoops = numberOfLoops
        self.player.prepareToPlay()
        self.player.delegate = self

        self.delegate?.onPlayerLoaded(self.id, duration: self.player.duration)
    }

    deinit {
        self.player.stop()
        self.stopPositionUpdates()
        self.delegate?.onPlayerUnloaded(self.id)
        self.player.delegate = nil
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
            guard
                let self = self,
                self.isPlaying,
                let delegate = self.delegate
            else { return }

            DispatchQueue.main.async {
                delegate.onPlayerPositionUpdated(self.id, currentTime: self.currentTime)
            }
        }

        self.timer?.resume()
    }

    private func stopPositionUpdates() {
        self.timer?.cancel()
        self.timer = nil

        if self.enablePositionUpdates {
            let delegate = self.delegate
            DispatchQueue.main.async {
                delegate?.onPlayerPositionUpdated(self.id, currentTime: self.currentTime)
            }
        }
    }

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopPositionUpdates()

        guard
            let delegate = self.delegate
        else { return }

        if flag {
            delegate.onPlayerCompleted(self.id)
        }
    }

    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        self.stopPositionUpdates()

        guard
            let delegate = self.delegate
        else { return }

        delegate.onPlayerError(
            self.id,
            error: error?.localizedDescription ?? "Unknown error"
        )
    }
}

extension AssetPlayer: PlayerProtocol {
    @objc public var state: [String: Any] {
        get {
            return [
                "type": "asset",
                "id": self.id,
                "enablePositionUpdates": self.enablePositionUpdates,
                "positionUpdateInterval": self.positionUpdateInterval,
                "isPlaying": self.isPlaying,
                "currentTime": self.currentTime,
                "duration": self.duration,
                "volume": self.volume,
                "rate": self.rate,
                "numberOfLoops": self.numberOfLoops,
            ]
        }
    }

    @objc public var enablePositionUpdates: Bool {
        get {
            // return self.queue.sync {
            return self._enablePositionUpdates
            // }
        }
        set(newValue) {
            let oldValue = self.enablePositionUpdates
            // self.queue.async(flags: .barrier) {
            self._enablePositionUpdates = newValue
            // }

            if newValue && !oldValue {
                if self.isPlaying {
                    self.startPositionUpdates()
                }
            } else if !newValue && oldValue {
                self.stopPositionUpdates()
            }

        }
    }

    @objc public var positionUpdateInterval: TimeInterval {
        get {
            // return self.queue.sync {
            return self._positionUpdateInterval
            // }
        }
        set(newValue) {
            let clampedInterval = max(0.1, min(2.0, newValue))
            // self.queue.async(flags: .barrier) {
            self._positionUpdateInterval = clampedInterval
            // }

            if self.enablePositionUpdates && self.isPlaying {
                self.stopPositionUpdates()
                self.startPositionUpdates()
            }
        }
    }

    @objc public var isPlaying: Bool { return self.player.isPlaying }

    @objc public var currentTime: TimeInterval {
        get { return self.player.currentTime }
        set(newValue) { self.player.currentTime = max(0, min(newValue, self.duration)) }
    }

    @objc public var duration: TimeInterval {
        return self.player.duration
    }

    @objc public var volume: Float {
        get { return self.player.volume }
        set(newValue) { self.player.volume = max(0.0, min(1.0, newValue)) }
    }

    @objc public var rate: Float {
        get { return self.player.rate }
        set(newValue) { self.player.rate = max(0.5, min(2.0, newValue)) }
    }

    @objc public var numberOfLoops: Int {
        get { return self.player.numberOfLoops }
        set(newValue) { self.player.numberOfLoops = max(-1, newValue) }
    }

    @objc public func play() -> Bool {
        if !self.isPlaying {
            if self.player.play() {
                self.startPositionUpdates()
                self.delegate?.onPlayerStarted(self.id)
            }
        }
        return self.isPlaying
    }

    @objc public func pause() -> Bool {
        if self.isPlaying {
            self.player.pause()
            self.stopPositionUpdates()
            self.delegate?.onPlayerPaused(self.id)
        }
        return self.isPlaying
    }

    @objc public func stop() -> Bool {
        if self.isPlaying {
            self.player.stop()
            self.stopPositionUpdates()
        }
        self.currentTime = 0
        self.delegate?.onPlayerStopped(self.id)
        return self.isPlaying
    }

    @objc public func seek(to time: TimeInterval) -> TimeInterval {
        self.currentTime = time
        self.delegate?.onPlayerSeeked(self.id, currentTime: self.currentTime)
        return self.currentTime
    }
}
