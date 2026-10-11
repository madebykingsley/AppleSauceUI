import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

#if DEBUG
enum DifferenceRenderer {
    @MainActor
    static func render<Content: View>(
        content: Content,
        reference: UIImage,
        size: CGSize,
        scale: CGFloat,
        colorScheme: ColorScheme,
        dynamicTypeSize: DynamicTypeSize
    ) -> UIImage? {
        guard size.width > 0, size.height > 0 else {
            return nil
        }

        let rootView = content
            .frame(width: size.width, height: size.height)
            .environment(\.colorScheme, colorScheme)
            .environment(\.dynamicTypeSize, dynamicTypeSize)
        let hostingController = UIHostingController(rootView: rootView)
        let bounds = CGRect(origin: .zero, size: size)
        hostingController.view.frame = bounds
        hostingController.view.backgroundColor = .clear
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        format.opaque = true
        let actualImage = UIGraphicsImageRenderer(bounds: bounds, format: format).image { _ in
            hostingController.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }

        guard let actualCIImage = CIImage(image: actualImage),
              let referenceCIImage = CIImage(image: reference) else {
            return nil
        }

        let targetExtent = actualCIImage.extent
        let normalizedReference = referenceCIImage.transformed(
            by: CGAffineTransform(
                scaleX: targetExtent.width / referenceCIImage.extent.width,
                y: targetExtent.height / referenceCIImage.extent.height
            )
        )

        let difference = CIFilter.differenceBlendMode()
        difference.inputImage = actualCIImage
        difference.backgroundImage = normalizedReference

        let emphasis = CIFilter.colorControls()
        emphasis.inputImage = difference.outputImage
        emphasis.contrast = 4
        emphasis.saturation = 0

        let heatmap = CIFilter.colorMatrix()
        heatmap.inputImage = emphasis.outputImage
        heatmap.rVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        heatmap.gVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        heatmap.bVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        heatmap.aVector = CIVector(x: 0.333, y: 0.333, z: 0.333, w: 0)
        heatmap.biasVector = CIVector(x: 1, y: 0.2, z: 0, w: 0)

        guard let output = heatmap.outputImage,
              let cgImage = CIContext(options: [.cacheIntermediates: false])
                .createCGImage(output, from: targetExtent) else {
            return nil
        }

        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
}
#endif
