import Foundation

@objc public class URLResolver: NSObject {
    public static let shared = URLResolver()

    private static let queue = DispatchQueue(
        label: "com.kolirt.plugins.native_audio.url_resolver.queue",
        attributes: .concurrent
    )

    private static var temporaryFileURLs: [String: URL] = [:]

    private override init() {
        super.init()
    }

    @objc public static func resolveURL(source: String, id: String) async throws -> URL {
        let url: URL
        if source.lowercased().hasPrefix("http://") || source.lowercased().hasPrefix("https://") {
            guard let remoteURL = URL(string: source) else {
                throw NSError(
                    domain: "NativeAudio",
                    code: -2,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                )
            }

            if let existingURL = self.getTemporaryFileURL(for: id) {
                if FileManager.default.fileExists(atPath: existingURL.path) {
                    print("Using cached temporary file for id: \(id)")
                    return existingURL
                }
            }

            let (data, _) = try await URLSession.shared.data(from: remoteURL)
            let tempDir = FileManager.default.temporaryDirectory

            // Get the file extension from the original URL
            let sourceExtension = (source as NSString).pathExtension
            let fileExtension = sourceExtension.isEmpty ? "m4a" : sourceExtension
            let tempFile = tempDir.appendingPathComponent("\(id).\(fileExtension)")

            if FileManager.default.fileExists(atPath: tempFile.path) {
                try? FileManager.default.removeItem(at: tempFile)
            }

            try data.write(to: tempFile)
            url = tempFile

            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs[id] = url
            }
        } else {
            let fileManager = FileManager.default
            let sourceWithoutExtension = (source as NSString).deletingPathExtension
            let fileExtension = (source as NSString).pathExtension

            if let path = Bundle.main.path(
                forResource: sourceWithoutExtension,
                ofType: fileExtension.isEmpty ? nil : fileExtension
            ) {
                url = URL(fileURLWithPath: path)
            } else {
                let wwwPath = Bundle.main.bundlePath + "/_capacitor_/public/" + source
                if fileManager.fileExists(atPath: wwwPath) {
                    url = URL(fileURLWithPath: wwwPath)
                } else {
                    throw NSError(
                        domain: "NativeAudio",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "File not found"]
                    )
                }
            }
        }
        return url
    }

    @objc public static func cleanupAllTemporaryFiles() {
        var ids: [String] = []
        self.queue.sync {
            ids = Array(self.temporaryFileURLs.keys)
        }

        for id in ids {
            self.cleanupTemporaryFile(for: id)
        }

        self.queue.async(flags: .barrier) {
            self.temporaryFileURLs.removeAll()
        }
    }

    @objc public static func cleanupTemporaryFile(for id: String) {
        guard let url = self.getTemporaryFileURL(for: id) else { return }

        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            self.queue.async(flags: .barrier) {
                self.temporaryFileURLs.removeValue(forKey: id)
            }
        } catch {
        }
    }

    @objc public static func getTemporaryFileURL(for id: String) -> URL? {
        var tempURL: URL?
        self.queue.sync {
            tempURL = self.temporaryFileURLs[id]
        }
        return tempURL
    }
}
