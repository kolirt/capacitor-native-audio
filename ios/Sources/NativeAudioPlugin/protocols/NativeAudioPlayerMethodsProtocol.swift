import AVFoundation

@objc public protocol NativeAudioPlayerMethodsProtocol: AnyObject {
    var players: [String: PlayerProtocol] { get set }

    @objc func getPlayers() throws -> [String: Any]

    @objc func preload(
        _ type: String,
        _ id: String,
        source: String,
        volume: NSNumber?,
        rate: NSNumber?,
        numberOfLoops: NSNumber?,
        enablePositionUpdates: NSNumber?,
        positionUpdateInterval: NSNumber?
    ) async throws -> [String: Any]

    @objc func unload(_ id: String) throws -> [String: Any]
    @objc func getState(_ id: String) throws -> [String: Any]
    @objc func play(_ id: String) throws -> [String: Any]
    @objc func pause(_ id: String) throws -> [String: Any]
    @objc func stop(_ id: String) throws -> [String: Any]
    @objc func seek(_ id: String, time: TimeInterval) throws -> [String: Any]

    @objc func setVolume(_ id: String, volume: Float) throws -> [String: Any]
    @objc func setRate(_ id: String, rate: Float) throws -> [String: Any]

    @objc func setNumberOfLoops(
        _ id: String,
        numberOfLoops: Int
    ) throws -> [String: Any]

    @objc func setEnablePositionUpdates(
        _ id: String,
        enabled: Bool
    ) throws -> [String: Any]

    @objc func setPositionUpdateInterval(
        _ id: String,
        interval: TimeInterval
    ) throws -> [String: Any]

    @objc func getPlayer(_ id: String) throws -> PlayerProtocol
    @objc func addPlayer(_ id: String, player: PlayerProtocol)
    @objc func removePlayer(_ id: String)
}
