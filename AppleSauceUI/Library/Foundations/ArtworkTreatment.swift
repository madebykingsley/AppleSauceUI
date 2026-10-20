import SwiftUI

/// Semantic treatment applied to artwork independently from the active Style Profile's identity.
enum ArtworkTreatment: Sendable {
    /// Preserve the supplied artwork without a color or contrast overlay.
    case unmodified
    /// Apply the active Style Profile's contrast treatment behind overlaid text.
    case textLegibility
}
