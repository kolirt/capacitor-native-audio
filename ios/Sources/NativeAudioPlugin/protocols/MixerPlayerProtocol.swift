import AVFoundation

@objc public protocol MixerPlayerProtocol: AnyObject {
    var player: AssetPlayer? { get set }
    var backgroundPlayers: [String: AssetPlayer] { get set }

    @objc func preloadBackground(
        _ id: String,
        url: URL,
        volume: Float,
        rate: Float
    ) async throws -> [String: Any]
    @objc func unloadBackground(_ id: String) throws -> [String: Any]

    @objc func getBackgroundPlayer(_ id: String) throws -> AssetPlayer
    @objc func addBackgroundPlayer(_ id: String, player: AssetPlayer)
    @objc func removeBackgroundPlayer(_ id: String)
}
