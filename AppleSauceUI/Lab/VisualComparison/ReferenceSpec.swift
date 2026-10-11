import SwiftUI
import UIKit

struct ReferenceSpec {
    enum Device: String {
        case iPhone = "iPhone"
        case iPad = "iPad"
        case Mac = "Mac"
        case visionPro = "Apple Vision Pro"
        case unspecified = "Current run destination"
    }

    enum Orientation: String {
        case portrait = "Portrait"
        case landscape = "Landscape"
    }

    let id: String
    let device: Device
    let orientation: Orientation
    let colorScheme: ColorScheme
    let dynamicTypeSize: DynamicTypeSize
    let notes: String?

    init(
        id: String,
        device: Device = .unspecified,
        orientation: Orientation = .portrait,
        colorScheme: ColorScheme = .light,
        dynamicTypeSize: DynamicTypeSize = .large,
        notes: String? = nil
    ) {
        self.id = id
        self.device = device
        self.orientation = orientation
        self.colorScheme = colorScheme
        self.dynamicTypeSize = dynamicTypeSize
        self.notes = notes
    }

    func loadImage(in bundle: Bundle = .main) -> UIImage? {
        guard let url = resourceURL(withExtension: "png", in: bundle) else {
            return nil
        }

        return UIImage(contentsOfFile: url.path)
    }

    func loadMetadata(in bundle: Bundle = .main) -> Data? {
        guard let url = resourceURL(withExtension: "json", in: bundle) else {
            return nil
        }

        return try? Data(contentsOf: url)
    }

    private func resourceURL(withExtension fileExtension: String, in bundle: Bundle) -> URL? {
        let semanticDirectory = id
            .split(separator: "/")
            .map { segment in
                segment
                    .split(separator: "-")
                    .map { $0.prefix(1).uppercased() + $0.dropFirst() }
                    .joined()
            }
            .joined(separator: "/")

        let candidateSubdirectories = [
            "Lab/References/\(semanticDirectory)",
            "References/\(semanticDirectory)",
            semanticDirectory
        ]
        let screenName = id.split(separator: "/").last?.lowercased()
        let targetResourceName = id.replacingOccurrences(of: "/", with: "-") + "-reference"
        let resourceNames = [targetResourceName, screenName.map { "\($0)-reference" }, "reference"].compactMap { $0 }

        for resourceName in resourceNames {
            for subdirectory in candidateSubdirectories {
                if let url = bundle.url(
                    forResource: resourceName,
                    withExtension: fileExtension,
                    subdirectory: subdirectory
                ) {
                    return url
                }
            }

            // Xcode may flatten individually-added resources at bundle time.
            if let url = bundle.url(forResource: resourceName, withExtension: fileExtension) {
                return url
            }
        }

        return nil
    }
}
