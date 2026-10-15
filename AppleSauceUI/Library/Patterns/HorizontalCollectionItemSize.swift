import SwiftUI

/// A semantic item-width tier for horizontally scrolling collections.
enum HorizontalCollectionItemSize: Sendable {
    case compact
    case standard
    case wide

    /// Resolves the tier for a demonstrated platform and density context.
    func width(in context: HorizontalCollectionSizingContext) -> CGFloat {
        switch context {
        case .iPhoneStandard:
            switch self {
            case .compact: 161
            case .standard: 249
            case .wide: 334
            }
        }
    }
}

/// A demonstrated platform and density combination for collection sizing.
enum HorizontalCollectionSizingContext: Sendable {
    case iPhoneStandard
}
