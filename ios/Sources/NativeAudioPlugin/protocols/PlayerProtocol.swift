import AVFoundation

@objc public protocol PlayerProtocol: AnyObject {
    var id: String { get }

    @objc var state: [String: Any] { get }

    @objc var enablePositionUpdates: Bool { get set }
    @objc var positionUpdateInterval: TimeInterval { get set }

    @objc var isPlaying: Bool { get }
    @objc var currentTime: TimeInterval { get set }
    @objc var duration: TimeInterval { get }
    @objc var volume: Float { get set }
    @objc var rate: Float { get set }
    @objc var numberOfLoops: Int { get set }

    @objc func play() -> Bool
    @objc func pause() -> Bool
    @objc func stop() -> Bool
    @objc func seek(to time: TimeInterval) -> TimeInterval
}
