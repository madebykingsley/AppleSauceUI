#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

enum ToolError: Error, CustomStringConvertible {
    case usage
    case unreadableImage(String)
    case dimensionMismatch(reference: CGSize, actual: CGSize)
    case processingFailed(String)

    var description: String {
        switch self {
        case .usage:
            return "Usage: VisualComparisonImageTool <reference.png> <actual.png> <overlay.png> <diff.png>"
        case .unreadableImage(let path):
            return "Could not read image: \(path)"
        case .dimensionMismatch(let reference, let actual):
            return """
            Dimension mismatch

            Reference: \(Int(reference.width)) × \(Int(reference.height))
            Actual:    \(Int(actual.width)) × \(Int(actual.height))

            Diff not generated.
            Use the simulator/device configuration associated with this reference.
            """
        case .processingFailed(let message):
            return "Image processing failed: \(message)"
        }
    }
}

struct PixelImage {
    let width: Int
    let height: Int
    var pixels: [UInt8]

    var size: CGSize {
        CGSize(width: width, height: height)
    }
}

func loadImage(at path: String) throws -> PixelImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        throw ToolError.unreadableImage(path)
    }

    let width = image.width
    let height = image.height
    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        | CGBitmapInfo.byteOrder32Big.rawValue

    guard let context = CGContext(
        data: &pixels,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else {
        throw ToolError.processingFailed("Could not decode \(path) into RGBA pixels.")
    }

    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
    return PixelImage(width: width, height: height, pixels: pixels)
}

func writePNG(_ image: PixelImage, to path: String) throws {
    let bytesPerRow = image.width * 4
    var pixels = image.pixels
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        | CGBitmapInfo.byteOrder32Big.rawValue

    guard let context = CGContext(
        data: &pixels,
        width: image.width,
        height: image.height,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ),
    let cgImage = context.makeImage() else {
        throw ToolError.processingFailed("Could not render \(path).")
    }

    let data = NSMutableData()
    guard let destination = CGImageDestinationCreateWithData(
        data,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        throw ToolError.processingFailed("Could not prepare \(path) for writing.")
    }

    CGImageDestinationAddImage(destination, cgImage, nil)
    guard CGImageDestinationFinalize(destination),
          data.write(toFile: path, atomically: true) else {
        throw ToolError.processingFailed("Could not write \(path).")
    }
}

do {
    guard CommandLine.arguments.count == 5 else {
        throw ToolError.usage
    }

    let reference = try loadImage(at: CommandLine.arguments[1])
    let actual = try loadImage(at: CommandLine.arguments[2])
    guard reference.size == actual.size else {
        throw ToolError.dimensionMismatch(reference: reference.size, actual: actual.size)
    }

    var overlayPixels = reference.pixels
    var diffPixels = reference.pixels
    for index in stride(from: 0, to: reference.pixels.count, by: 4) {
        for channel in 0..<3 {
            let referenceValue = Int(reference.pixels[index + channel])
            let actualValue = Int(actual.pixels[index + channel])
            overlayPixels[index + channel] = UInt8((referenceValue + actualValue + 1) / 2)
            diffPixels[index + channel] = UInt8(min(abs(referenceValue - actualValue) * 4, 255))
        }
        overlayPixels[index + 3] = 255
        diffPixels[index + 3] = 255
    }

    try writePNG(
        PixelImage(width: reference.width, height: reference.height, pixels: overlayPixels),
        to: CommandLine.arguments[3]
    )
    try writePNG(
        PixelImage(width: reference.width, height: reference.height, pixels: diffPixels),
        to: CommandLine.arguments[4]
    )
    print("\(reference.width)x\(reference.height)")
} catch {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(1)
}
