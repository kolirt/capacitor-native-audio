import AVFoundation

@objc public protocol PlayerEventsProtocol: AnyObject {
    @objc func onPlayerLoaded(_ id: String, duration: TimeInterval)
    @objc func onPlayerUnloaded(_ id: String)
    @objc func onPlayerStarted(_ id: String)
    @objc func onPlayerPaused(_ id: String)
    @objc func onPlayerStopped(_ id: String)
    @objc func onPlayerSeeked(_ id: String, currentTime: TimeInterval)
    @objc func onPlayerCompleted(_ id: String)
    @objc func onPlayerError(_ id: String, error: String)
    @objc func onPlayerPositionUpdated(_ id: String, currentTime: TimeInterval)

    @objc func onMixerBackgroundLoaded(_ mixerId: String, _ backgroundId: String, duration: TimeInterval)
    @objc func onMixerBackgroundUnloaded(_ mixerId: String, _ backgroundId: String)
}
