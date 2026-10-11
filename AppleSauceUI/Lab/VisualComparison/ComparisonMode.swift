import Foundation

enum ComparisonMode: String, CaseIterable, Identifiable {
    case actual = "Actual"
    case reference = "Reference"
    case overlay = "Overlay"
    case difference = "Difference"

    var id: Self { self }
}
