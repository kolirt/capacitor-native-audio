import AVFoundation

@objc public protocol PlayerEventsProtocol: AnyObject {
    @objc func onAssetLoaded(_ id: String, duration: TimeInterval)
    @objc func onAssetUnloaded(_ id: String)
    @objc func onAssetStarted(_ id: String)
    @objc func onAssetPaused(_ id: String)
    @objc func onAssetStopped(_ id: String)
    @objc func onAssetSeeked(_ id: String, currentTime: TimeInterval)
    @objc func onAssetCompleted(_ id: String)
    @objc func onAssetError(_ id: String, error: String)
    @objc func onAssetPositionUpdated(_ id: String, currentTime: TimeInterval)

    @objc func onMixerLoaded(_ id: String, duration: TimeInterval)
    @objc func onMixerUnloaded(_ id: String)
    @objc func onMixerStarted(_ id: String)
    @objc func onMixerPaused(_ id: String)
    @objc func onMixerStopped(_ id: String)
    @objc func onMixerSeeked(_ id: String, currentTime: TimeInterval)
    @objc func onMixerCompleted(_ id: String)
    @objc func onMixerError(_ id: String, error: String)
    @objc func onMixerPositionUpdated(_ id: String, currentTime: TimeInterval)

    @objc func onMixerBackgroundLoaded(_ mixerId: String, _ backgroundId: String, duration: TimeInterval)
    @objc func onMixerBackgroundUnloaded(_ mixerId: String, _ backgroundId: String)
}
