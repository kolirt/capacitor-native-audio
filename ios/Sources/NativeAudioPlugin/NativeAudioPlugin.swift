import AVFoundation
import Capacitor
import Foundation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(NativeAudioPlugin)
public class NativeAudioPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "NativeAudioPlugin"
    public let jsName = "NativeAudio"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "configureSession", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pauseAllForInterruption", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resumeAllAfterInterruption", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getPlayers", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "preload", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "preloadMixerBackground", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "unload", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "unloadMixerBackground", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getState", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "play", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resume", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pause", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "stop", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "seek", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setVolume", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setRate", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setNumberOfLoops", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setEnablePositionUpdates", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setPositionUpdateInterval", returnType: CAPPluginReturnPromise),
    ]
    private let implementation = NativeAudio()

    private struct NotificationHandler {
        let name: NSNotification.Name
        let selector: Selector
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override public func load() {
        let handlers = [
            NotificationHandler(
                name: .init("NativeAudioPlayerLoaded"),
                selector: #selector(handlePlayerLoaded(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerUnloaded"),
                selector: #selector(handlePlayerUnloaded(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerStarted"),
                selector: #selector(handlePlayerStarted(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerPaused"),
                selector: #selector(handlePlayerPaused(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerStopped"),
                selector: #selector(handlePlayerStopped(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerSeeked"),
                selector: #selector(handlePlayerSeeked(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerCompleted"),
                selector: #selector(handlePlayerCompleted(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerError"),
                selector: #selector(handlePlayerError(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioPlayerPositionUpdated"),
                selector: #selector(handlePlayerPositionUpdated(_:))
            ),
        ]

        for handler in handlers {
            NotificationCenter.default.addObserver(
                self,
                selector: handler.selector,
                name: handler.name,
                object: nil
            )
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption(_:)),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRouteChange(_:)),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
    }

    @objc func configureSession(_ call: CAPPluginCall) {
        let enableAutoInterruptionHandlingBool = call.getBool("enableAutoInterruptionHandling")
        let enableAutoIosSessionDeactivationBool = call.getBool("enableAutoIosSessionDeactivation")
        let iosCategory = call.getString("iosCategory")
        let iosMode = call.getString("iosMode")
        let iosOptions = call.getArray("iosOptions", String.self)

        let enableAutoInterruptionHandling: NSNumber? = enableAutoInterruptionHandlingBool.map {
            NSNumber(booleanLiteral: $0)
        }
        let enableAutoIosSessionDeactivation: NSNumber? = enableAutoIosSessionDeactivationBool.map {
            NSNumber(booleanLiteral: $0)
        }

        do {
            try self.implementation.configureSession(
                enableAutoInterruptionHandling: enableAutoInterruptionHandling,
                enableAutoIosSessionDeactivation: enableAutoIosSessionDeactivation,
                iosCategory: iosCategory,
                iosMode: iosMode,
                iosOptions: iosOptions
            )
            call.resolve()
        } catch {
            call.reject("Failed to configure session: \(error.localizedDescription)")
        }
    }

    @objc func pauseAllForInterruption(_ call: CAPPluginCall) {
        call.resolve(self.implementation.pauseAllForInterruption())
    }

    @objc func resumeAllAfterInterruption(_ call: CAPPluginCall) {
        call.resolve(self.implementation.resumeAllAfterInterruption())
    }

    @objc func getPlayers(_ call: CAPPluginCall) {
        do {
            let result = try self.implementation.getPlayers()
            call.resolve(result)
        } catch {
            call.reject("Failed to get assets: \(error.localizedDescription)")
        }
    }

    @objc func preload(_ call: CAPPluginCall) {
        guard
            let type = call.getString("type"),
            let id = call.getString("id"),
            let source = call.getString("source")
        else {
            call.reject("Missing id or source")
            return
        }

        let volume: NSNumber? = call.getFloat("volume").map { NSNumber(value: $0) }
        let rate: NSNumber? = call.getFloat("rate").map { NSNumber(value: $0) }
        let numberOfLoops: NSNumber? = call.getInt("numberOfLoops").map { NSNumber(value: $0) }
        let enablePositionUpdates = call.getBool("enablePositionUpdates").map {
            NSNumber(booleanLiteral: $0)
        }
        let positionUpdateInterval = call.getDouble("positionUpdateInterval").map {
            NSNumber(value: $0)
        }

        Task {
            do {
                let result = try await self.implementation.preload(
                    type,
                    id,
                    source: source,
                    volume: volume,
                    rate: rate,
                    numberOfLoops: numberOfLoops,
                    enablePositionUpdates: enablePositionUpdates,
                    positionUpdateInterval: positionUpdateInterval
                )
                call.resolve(result)
            } catch {
                call.reject("Failed to preload audio: \(error.localizedDescription)")
            }
        }
    }

    @objc func preloadMixerBackground(_ call: CAPPluginCall) {
        guard
            let mixerId = call.getString("mixerId"),
            let id = call.getString("id"),
            let source = call.getString("source")
        else {
            call.reject("Missing mixerId, id, or source")
            return
        }

        let volume: NSNumber? = call.getFloat("volume").map { NSNumber(value: $0) }
        let rate: NSNumber? = call.getFloat("rate").map { NSNumber(value: $0) }

        Task {
            do {
                let result = try await self.implementation.preloadMixerBackground(
                    mixerId,
                    id,
                    source: source,
                    volume: volume,
                    rate: rate
                )
                call.resolve(result)
            } catch {
                call.reject("Failed to preload mixer background: \(error.localizedDescription)")
            }
        }
    }

    @objc func unload(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.unload(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to unload audio: \(error.localizedDescription)")
        }
    }

    @objc func unloadMixerBackground(_ call: CAPPluginCall) {
        guard
            let mixerId = call.getString("mixerId"),
            let id = call.getString("id")
        else {
            call.reject("Missing mixerId or id")
            return
        }
        do {
            let result = try self.implementation.unloadMixerBackground(mixerId, id)
            call.resolve(result)
        } catch {
            call.reject("Failed to unload mixer background: \(error.localizedDescription)")
        }
    }

    @objc func getState(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.getState(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to get state: \(error.localizedDescription)")
        }
    }

    @objc func play(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.play(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to play audio: \(error.localizedDescription)")
        }
    }

    @objc func resume(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.play(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to resume audio: \(error.localizedDescription)")
        }
    }

    @objc func pause(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.pause(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to pause audio: \(error.localizedDescription)")
        }
    }

    @objc func stop(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id")
        else {
            call.reject("Missing id")
            return
        }
        do {
            let result = try self.implementation.stop(id)
            call.resolve(result)
        } catch {
            call.reject("Failed to stop audio: \(error.localizedDescription)")
        }
    }

    @objc func seek(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let time = call.getDouble("time")
        else {
            call.reject("Missing id or time")
            return
        }
        do {
            let result = try self.implementation.seek(id, time: time)
            call.resolve(result)
        } catch {
            call.reject("Failed to seek audio: \(error.localizedDescription)")
        }
    }

    @objc func setVolume(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let volume = call.getFloat("volume")
        else {
            call.reject("Missing id or volume")
            return
        }
        do {
            let result = try self.implementation.setVolume(id, volume: volume)
            call.resolve(result)
        } catch {
            call.reject("Failed to set volume: \(error.localizedDescription)")
        }
    }

    @objc func setRate(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let rate = call.getFloat("rate")
        else {
            call.reject("Missing id or rate")
            return
        }
        do {
            let result = try self.implementation.setRate(id, rate: rate)
            call.resolve(result)
        } catch {
            call.reject("Failed to set rate: \(error.localizedDescription)")
        }
    }

    @objc func setNumberOfLoops(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let numberOfLoops = call.getInt("numberOfLoops")
        else {
            call.reject("Missing id or numberOfLoops")
            return
        }
        do {
            let result = try self.implementation.setNumberOfLoops(
                id,
                numberOfLoops: numberOfLoops
            )
            call.resolve(result)
        } catch {
            call.reject("Failed to set numberOfLoops: \(error.localizedDescription)")
        }
    }

    @objc func setEnablePositionUpdates(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let enabled = call.getBool("enabled")
        else {
            call.reject("Missing id or enabled")
            return
        }
        do {
            let result = try self.implementation.setEnablePositionUpdates(
                id,
                enabled: enabled
            )
            call.resolve(result)
        } catch {
            call.reject("Failed to set enablePositionUpdates: \(error.localizedDescription)")
        }
    }

    @objc func setPositionUpdateInterval(_ call: CAPPluginCall) {
        guard
            let id = call.getString("id"),
            let interval = call.getDouble("positionUpdateInterval")
        else {
            call.reject("Missing id or positionUpdateInterval")
            return
        }
        do {
            let result = try self.implementation.setPositionUpdateInterval(
                id,
                interval: interval
            )
            call.resolve(result)
        } catch {
            call.reject("Failed to set positionUpdateInterval: \(error.localizedDescription)")
        }
    }

    /**
     * Event listeners
     */

    @objc private func handlePlayerLoaded(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String,
            let duration = userInfo["duration"] as? TimeInterval
        else { return }

        notifyListeners(
            "playerLoaded",
            data: ["eventName": eventName, "id": id, "duration": duration]
        )
    }

    @objc private func handlePlayerUnloaded(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String
        else { return }

        notifyListeners(
            "playerUnloaded",
            data: ["eventName": eventName, "id": id]
        )
    }

    @objc private func handlePlayerStarted(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String
        else { return }

        notifyListeners(
            "playerStarted",
            data: ["eventName": eventName, "id": id]
        )
    }

    @objc private func handlePlayerPaused(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String
        else { return }

        notifyListeners(
            "playerPaused",
            data: ["eventName": eventName, "id": id]
        )
    }

    @objc private func handlePlayerStopped(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String
        else { return }

        notifyListeners(
            "playerStopped",
            data: ["eventName": eventName, "id": id]
        )
    }

    @objc private func handlePlayerSeeked(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String,
            let currentTime = userInfo["currentTime"] as? TimeInterval
        else { return }

        notifyListeners(
            "playerSeeked",
            data: ["eventName": eventName, "id": id, "currentTime": currentTime]
        )
    }

    @objc private func handlePlayerCompleted(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String
        else { return }

        notifyListeners(
            "playerCompleted",
            data: ["eventName": eventName, "id": id]
        )
    }

    @objc private func handlePlayerError(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String,
            let error = userInfo["error"] as? String
        else { return }

        notifyListeners(
            "playerError",
            data: ["eventName": eventName, "id": id, "error": error]
        )
    }

    @objc private func handlePlayerPositionUpdated(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let id = userInfo["id"] as? String,
            let currentTime = userInfo["currentTime"] as? TimeInterval
        else { return }

        notifyListeners(
            "playerPositionUpdated",
            data: ["eventName": eventName, "id": id, "currentTime": currentTime]
        )
    }

    /**
     * AVAudioSession notifications
     */

    @objc private func handleInterruption(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue)
        else { return }

        notifyListeners(
            "sessionInterrupted",
            data: [
                "eventName": "sessionInterrupted",
                "state": type == .began ? "began" : "ended",
            ]
        )

        if self.implementation.enableAutoInterruptionHandling {
            if type == .began {
                let _ = self.implementation.pauseAllForInterruption()
            } else if type == .ended {
                if let options = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt,
                    AVAudioSession.InterruptionOptions(rawValue: options).contains(.shouldResume)
                {
                    let _ = self.implementation.resumeAllAfterInterruption()
                }
            }
        }
    }

    @objc private func handleRouteChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt
        else { return }

        notifyListeners(
            "sessionRouteChanged",
            data: ["eventName": "sessionRouteChanged", "reason": reasonValue]
        )
    }
}
