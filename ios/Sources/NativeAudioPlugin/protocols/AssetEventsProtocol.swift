import AVFoundation

@objc public protocol AssetEventsProtocol: AnyObject {
    @objc func onAssetLoaded(_ id: String, duration: TimeInterval)
    @objc func onAssetUnloaded(_ id: String)
    @objc func onAssetStarted(_ id: String)
    @objc func onAssetPaused(_ id: String)
    @objc func onAssetStopped(_ id: String)
    @objc func onAssetSeeked(_ id: String, currentTime: TimeInterval)
    @objc func onAssetCompleted(_ id: String)
    @objc func onAssetError(_ id: String, error: String)
    @objc func onAssetPositionUpdated(_ id: String, currentTime: TimeInterval)
}
