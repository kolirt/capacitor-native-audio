import AVFoundation

@objc public protocol NativeAudioAssetMethodsProtocol: AnyObject {
    @objc func getAssets() throws -> [String: Any]

    @objc func preloadAsset(
        _ id: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?,
        numberOfLoops: NSNumber?,
        enablePositionUpdates: NSNumber?,
        positionUpdateInterval: NSNumber?
    ) async throws -> [String: Any]

    @objc func unloadAsset(_ id: String) throws -> [String: Any]
    @objc func getAssetState(_ id: String) throws -> [String: Any]
    @objc func playAsset(_ id: String) throws -> [String: Any]
    @objc func pauseAsset(_ id: String) throws -> [String: Any]
    @objc func stopAsset(_ id: String) throws -> [String: Any]
    @objc func seekAsset(_ id: String, time: TimeInterval) throws -> [String: Any]

    @objc func setAssetVolume(_ id: String, volume: Float) throws -> [String: Any]
    @objc func setAssetRate(_ id: String, rate: Float) throws -> [String: Any]

    @objc func setAssetNumberOfLoops(
        _ id: String,
        numberOfLoops: Int
    ) throws -> [String: Any]

    @objc func setAssetEnablePositionUpdates(
        _ id: String,
        enabled: Bool
    ) throws -> [String: Any]

    @objc func setAssetPositionUpdateInterval(
        _ id: String,
        interval: TimeInterval
    ) throws -> [String: Any]

    @objc func getAssetPlayer(_ id: String) throws -> AssetPlayer
    @objc func addAssetPlayer(_ id: String, player: AssetPlayer)
    @objc func removeAssetPlayer(_ id: String)
}
