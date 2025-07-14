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
        CAPPluginMethod(name: "pauseAllAssets", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resumeAllAssets", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getAssets", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "preloadAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "unloadAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getAssetState", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "playAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resumeAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pauseAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "stopAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "seekAsset", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setAssetVolume", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setAssetRate", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setAssetNumberOfLoops", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setAssetEnablePositionUpdates", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setAssetPositionUpdateInterval", returnType: CAPPluginReturnPromise),
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
                name: .init("NativeAudioAssetLoaded"),
                selector: #selector(handleAssetLoaded(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetUnloaded"),
                selector: #selector(handleAssetUnloaded(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetStarted"),
                selector: #selector(handleAssetStarted(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetPaused"),
                selector: #selector(handleAssetPaused(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetStopped"),
                selector: #selector(handleAssetStopped(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetSeeked"),
                selector: #selector(handleAssetSeeked(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetCompleted"),
                selector: #selector(handleAssetCompleted(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetError"),
                selector: #selector(handleAssetError(_:))
            ),
            NotificationHandler(
                name: .init("NativeAudioAssetPositionUpdate"),
                selector: #selector(handleAssetPositionUpdate(_:))
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

    @objc func pauseAllAssets(_ call: CAPPluginCall) {
        call.resolve([
            "pausedAssetIds": self.implementation.pauseAllAssetsForInterruption()
        ])
    }

    @objc func resumeAllAssets(_ call: CAPPluginCall) {
        call.resolve([
            "resumedAssetIds": self.implementation.resumeAllAssetsAfterInterruption()
        ])
    }

    @objc func getAssets(_ call: CAPPluginCall) {
        do {
            let result = try self.implementation.getAssets()
            call.resolve(result)
        } catch {
            call.reject("Failed to get assets: \(error.localizedDescription)")
        }
    }

    @objc func preloadAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let source = call.getString("source")
        else {
            call.reject("Missing assetId or source")
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
                let result = try await self.implementation.preloadAsset(
                    assetId,
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

    @objc func unloadAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.unloadAsset(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to unload audio: \(error.localizedDescription)")
        }
    }

    @objc func getAssetState(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.getAssetState(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to get state: \(error.localizedDescription)")
        }
    }

    @objc func playAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.playAsset(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to play audio: \(error.localizedDescription)")
        }
    }

    @objc func resumeAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.resumeAsset(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to resume audio: \(error.localizedDescription)")
        }
    }

    @objc func pauseAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.pauseAsset(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to pause audio: \(error.localizedDescription)")
        }
    }

    @objc func stopAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId")
        else {
            call.reject("Missing assetId")
            return
        }
        do {
            let result = try self.implementation.stopAsset(assetId)
            call.resolve(result)
        } catch {
            call.reject("Failed to stop audio: \(error.localizedDescription)")
        }
    }

    @objc func seekAsset(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let time = call.getDouble("time")
        else {
            call.reject("Missing assetId or time")
            return
        }
        do {
            let result = try self.implementation.seekAsset(assetId, time: time)
            call.resolve(result)
        } catch {
            call.reject("Failed to seek audio: \(error.localizedDescription)")
        }
    }

    @objc func setAssetVolume(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let volume = call.getFloat("volume")
        else {
            call.reject("Missing assetId or volume")
            return
        }
        do {
            let result = try self.implementation.setAssetVolume(assetId, volume: volume)
            call.resolve(result)
        } catch {
            call.reject("Failed to set volume: \(error.localizedDescription)")
        }
    }

    @objc func setAssetRate(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let rate = call.getFloat("rate")
        else {
            call.reject("Missing assetId or rate")
            return
        }
        do {
            let result = try self.implementation.setAssetRate(assetId, rate: rate)
            call.resolve(result)
        } catch {
            call.reject("Failed to set rate: \(error.localizedDescription)")
        }
    }

    @objc func setAssetNumberOfLoops(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let numberOfLoops = call.getInt("numberOfLoops")
        else {
            call.reject("Missing assetId or numberOfLoops")
            return
        }
        do {
            let result = try self.implementation.setAssetNumberOfLoops(
                assetId, numberOfLoops: numberOfLoops)
            call.resolve(result)
        } catch {
            call.reject("Failed to set numberOfLoops: \(error.localizedDescription)")
        }
    }

    @objc func setAssetEnablePositionUpdates(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let enabled = call.getBool("enabled")
        else {
            call.reject("Missing assetId or enabled")
            return
        }
        do {
            let result = try self.implementation.setAssetEnablePositionUpdates(assetId, enabled: enabled)
            call.resolve(result)
        } catch {
            call.reject("Failed to set enablePositionUpdates: \(error.localizedDescription)")
        }
    }

    @objc func setAssetPositionUpdateInterval(_ call: CAPPluginCall) {
        guard
            let assetId = call.getString("assetId"),
            let interval = call.getDouble("positionUpdateInterval")
        else {
            call.reject("Missing assetId or positionUpdateInterval")
            return
        }
        do {
            let result = try self.implementation.setAssetPositionUpdateInterval(assetId, interval: interval)
            call.resolve(result)
        } catch {
            call.reject("Failed to set positionUpdateInterval: \(error.localizedDescription)")
        }
    }

    /**
     * Event listeners
     */

    @objc private func handleAssetLoaded(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String,
            let duration = userInfo["duration"] as? TimeInterval
        else { return }

        notifyListeners(
            "assetLoaded",
            data: ["eventName": eventName, "assetId": assetId, "duration": duration]
        )
    }

    @objc private func handleAssetUnloaded(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String
        else { return }

        notifyListeners(
            "assetUnloaded",
            data: ["eventName": eventName, "assetId": assetId]
        )
    }

    @objc private func handleAssetStarted(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String
        else { return }

        notifyListeners(
            "assetStarted",
            data: ["eventName": eventName, "assetId": assetId]
        )
    }

    @objc private func handleAssetPaused(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String
        else { return }

        notifyListeners(
            "assetPaused",
            data: ["eventName": eventName, "assetId": assetId]
        )
    }

    @objc private func handleAssetStopped(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String
        else { return }

        notifyListeners(
            "assetStopped",
            data: ["eventName": eventName, "assetId": assetId]
        )
    }

    @objc private func handleAssetSeeked(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String,
            let currentTime = userInfo["currentTime"] as? TimeInterval
        else { return }

        notifyListeners(
            "assetSeeked",
            data: ["eventName": eventName, "assetId": assetId, "currentTime": currentTime]
        )
    }

    @objc private func handleAssetCompleted(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String
        else { return }

        notifyListeners(
            "assetCompleted",
            data: ["eventName": eventName, "assetId": assetId]
        )
    }

    @objc private func handleAssetError(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String,
            let error = userInfo["error"] as? String
        else { return }

        notifyListeners(
            "assetError",
            data: ["eventName": eventName, "assetId": assetId, "error": error]
        )
    }

    @objc private func handleAssetPositionUpdate(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let eventName = userInfo["eventName"] as? String,
            let assetId = userInfo["assetId"] as? String,
            let currentTime = userInfo["currentTime"] as? TimeInterval
        else { return }

        notifyListeners(
            "assetPositionUpdate",
            data: ["eventName": eventName, "assetId": assetId, "currentTime": currentTime]
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

        if self.implementation.isAutoInterruptionHandlingEnabled {
            if type == .began {
                let _ = self.implementation.pauseAllAssetsForInterruption()
            } else if type == .ended {
                if let options = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt,
                    AVAudioSession.InterruptionOptions(rawValue: options).contains(.shouldResume)
                {
                    let _ = self.implementation.resumeAllAssetsAfterInterruption()
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
