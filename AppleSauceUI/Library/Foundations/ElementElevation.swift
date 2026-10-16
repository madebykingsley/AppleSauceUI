import SwiftUI

/// The semantic elevation an Element requests from the active Style Profile.
enum ElementElevation: Equatable, Sendable {
    case none
    case subtle
    case standard
    case prominent
}

struct StyleProfileShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    static let none = StyleProfileShadow(color: .clear, radius: 0, x: 0, y: 0)
}
