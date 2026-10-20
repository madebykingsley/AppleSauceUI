#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

enum MetadataError: Error, CustomStringConvertible {
    case usage
    case invalid(String)

    var description: String {
        switch self {
        case .usage:
            return "Usage: ReferenceMetadataTool <validate|section> <metadata.json> <reference.png> [section-name output.png]"
        case .invalid(let message):
            return "Invalid reference metadata: \(message)"
        }
    }
}

struct PixelSize: Decodable, Equatable {
    let widthPixels: Int
    let heightPixels: Int
}

struct PixelRect: Decodable {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

struct ReferenceSection: Decodable {
    let name: String
    let rectPixels: PixelRect
    let position: String
}

struct ReferenceImageMetadata: Decodable {
    let widthPixels: Int
    let heightPixels: Int
    let scale: Double?
}

struct CaptureMetadata: Decodable {
    let position: String
}

struct ReferenceMetadata: Decodable {
    let schemaVersion: Int
    let target: String
    let screen: String
    let referenceType: String
    let image: ReferenceImageMetadata
    let viewport: PixelSize?
    let appearance: String
    let dynamicType: String
    let capture: CaptureMetadata
    let sections: [ReferenceSection]
    let supportsFullContentComparison: Bool
}

func imageSize(at path: String) throws -> PixelSize {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
          let width = properties[kCGImagePropertyPixelWidth] as? Int,
          let height = properties[kCGImagePropertyPixelHeight] as? Int else {
        throw MetadataError.invalid("could not read PNG dimensions at \(path)")
    }
    return PixelSize(widthPixels: width, heightPixels: height)
}

func loadMetadata(at path: String) throws -> ReferenceMetadata {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(ReferenceMetadata.self, from: data)
    } catch {
        throw MetadataError.invalid("could not decode \(path): \(error.localizedDescription)")
    }
}

func validate(_ metadata: ReferenceMetadata, referencePath: String) throws {
    guard metadata.schemaVersion == 1 else {
        throw MetadataError.invalid("schemaVersion must be 1")
    }
    guard ["singleViewport", "longScrolling"].contains(metadata.referenceType) else {
        throw MetadataError.invalid("referenceType must be singleViewport or longScrolling")
    }
    guard !metadata.target.isEmpty, !metadata.screen.isEmpty else {
        throw MetadataError.invalid("target and screen must not be empty")
    }
    guard ["light", "dark"].contains(metadata.appearance) else {
        throw MetadataError.invalid("appearance must be light or dark")
    }
    guard !metadata.dynamicType.isEmpty, !metadata.capture.position.isEmpty else {
        throw MetadataError.invalid("dynamicType and capture.position must not be empty")
    }
    guard metadata.image.widthPixels > 0, metadata.image.heightPixels > 0 else {
        throw MetadataError.invalid("image dimensions must be positive")
    }
    if let scale = metadata.image.scale, scale <= 0 {
        throw MetadataError.invalid("image.scale must be positive or null when unknown")
    }
    if let viewport = metadata.viewport {
        guard viewport.widthPixels > 0, viewport.heightPixels > 0 else {
            throw MetadataError.invalid("viewport dimensions must be positive when known")
        }
    }
    let actualSize = try imageSize(at: referencePath)
    let declaredSize = PixelSize(widthPixels: metadata.image.widthPixels, heightPixels: metadata.image.heightPixels)
    guard actualSize == declaredSize else {
        throw MetadataError.invalid("declared image is \(declaredSize.widthPixels)x\(declaredSize.heightPixels), but PNG is \(actualSize.widthPixels)x\(actualSize.heightPixels)")
    }
    if metadata.referenceType == "singleViewport" {
        guard metadata.sections.isEmpty else {
            throw MetadataError.invalid("singleViewport references must not declare sections")
        }
        if let viewport = metadata.viewport, viewport != actualSize {
            throw MetadataError.invalid("singleViewport image and viewport dimensions must match")
        }
    }
    var names = Set<String>()
    for section in metadata.sections {
        let rect = section.rectPixels
        guard !section.name.isEmpty, !section.position.isEmpty, names.insert(section.name).inserted else {
            throw MetadataError.invalid("section names and positions must be non-empty and names must be unique")
        }
        guard rect.x >= 0, rect.y >= 0, rect.width > 0, rect.height > 0,
              rect.x + rect.width <= actualSize.widthPixels,
              rect.y + rect.height <= actualSize.heightPixels else {
            throw MetadataError.invalid("section '\(section.name)' is outside the canonical image bounds")
        }
        if let viewport = metadata.viewport,
           (rect.width != viewport.widthPixels || rect.height != viewport.heightPixels) {
            throw MetadataError.invalid("section '\(section.name)' does not match the declared viewport dimensions")
        }
    }
}

func crop(referencePath: String, rect: PixelRect, outputPath: String) throws {
    let url = URL(fileURLWithPath: referencePath)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let cropped = image.cropping(to: CGRect(x: rect.x, y: image.height - rect.y - rect.height, width: rect.width, height: rect.height)) else {
        throw MetadataError.invalid("could not crop the requested section")
    }
    guard let destination = CGImageDestinationCreateWithURL(
        URL(fileURLWithPath: outputPath) as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        throw MetadataError.invalid("could not prepare the derived crop")
    }
    CGImageDestinationAddImage(destination, cropped, nil)
    guard CGImageDestinationFinalize(destination) else {
        throw MetadataError.invalid("could not write the derived crop")
    }
}

do {
    guard CommandLine.arguments.count >= 4 else { throw MetadataError.usage }
    let command = CommandLine.arguments[1]
    let metadata = try loadMetadata(at: CommandLine.arguments[2])
    let referencePath = CommandLine.arguments[3]
    try validate(metadata, referencePath: referencePath)

    switch command {
    case "validate":
        guard CommandLine.arguments.count == 4 else { throw MetadataError.usage }
        let imageScale = metadata.image.scale.map { String($0) } ?? "unknown"
        let viewportDimensions = metadata.viewport.map { "\($0.widthPixels)x\($0.heightPixels)" } ?? "unknown"
        print("target=\(metadata.target)")
        print("screen=\(metadata.screen)")
        print("referenceType=\(metadata.referenceType)")
        print("imageDimensions=\(metadata.image.widthPixels)x\(metadata.image.heightPixels)")
        print("imageScale=\(imageScale)")
        print("viewportDimensions=\(viewportDimensions)")
        print("appearance=\(metadata.appearance)")
        print("dynamicType=\(metadata.dynamicType)")
        print("capturePosition=\(metadata.capture.position)")
        print("supportsFullContentComparison=\(metadata.supportsFullContentComparison)")
    case "section":
        guard CommandLine.arguments.count == 6 else { throw MetadataError.usage }
        let name = CommandLine.arguments[4]
        guard metadata.referenceType == "longScrolling" else {
            throw MetadataError.invalid("named sections require a longScrolling reference")
        }
        guard let section = metadata.sections.first(where: { $0.name == name }) else {
            throw MetadataError.invalid("unknown section '\(name)'; available: \(metadata.sections.map(\.name).joined(separator: ", "))")
        }
        try crop(referencePath: referencePath, rect: section.rectPixels, outputPath: CommandLine.arguments[5])
        let rect = section.rectPixels
        print("sectionName=\(section.name)")
        print("sectionPosition=\(section.position)")
        print("sectionRect=\(rect.x),\(rect.y),\(rect.width),\(rect.height)")
    default:
        throw MetadataError.usage
    }
} catch {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(1)
}
