import CoreGraphics

/// Display geometry owned by an artwork container rather than its supplied content.
enum ArtworkContainerGeometry: Equatable {
    case aspectRatio(CGFloat)
    case size(CGSize)
    case height(CGFloat)
    case minimumHeight(CGFloat)
}
