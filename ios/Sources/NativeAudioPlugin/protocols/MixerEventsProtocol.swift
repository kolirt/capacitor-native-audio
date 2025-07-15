import AVFoundation

@objc public protocol MixerEventsProtocol: AnyObject {
    @objc func onMixerLoaded(_ id: String, duration: TimeInterval)
    @objc func onMixerUnloaded(_ id: String)
    @objc func onMixerStarted(_ id: String)
    @objc func onMixerPaused(_ id: String)
    @objc func onMixerStopped(_ id: String)
    @objc func onMixerSeeked(_ id: String, currentTime: TimeInterval)
    @objc func onMixerCompleted(_ id: String)
    @objc func onMixerError(_ id: String, error: String)
    @objc func onMixerPositionUpdated(_ id: String, currentTime: TimeInterval)
}
