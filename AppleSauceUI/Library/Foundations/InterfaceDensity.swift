import SwiftUI

/// Controls broad layout rhythm independently from visual language.
enum InterfaceDensity: String, CaseIterable, Identifiable, Sendable {
    case compact
    case standard
    case spacious

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .compact: "Compact"
        case .standard: "Standard"
        case .spacious: "Spacious"
        }
    }

    var metrics: InterfaceDensityMetrics {
        switch self {
        case .compact:
            InterfaceDensityMetrics(sectionSpacing: 8, itemSpacing: 8, collectionRowSpacing: 14, contentMargin: 16, contentPadding: 10, metadataSpacing: 4)
        case .standard:
            InterfaceDensityMetrics(sectionSpacing: 12, itemSpacing: 12, collectionRowSpacing: 20, contentMargin: 20, contentPadding: 12, metadataSpacing: 6)
        case .spacious:
            InterfaceDensityMetrics(sectionSpacing: 18, itemSpacing: 18, collectionRowSpacing: 28, contentMargin: 24, contentPadding: 16, metadataSpacing: 10)
        }
    }
}

struct InterfaceDensityMetrics: Equatable {
    let sectionSpacing: CGFloat
    let itemSpacing: CGFloat
    let collectionRowSpacing: CGFloat
    let contentMargin: CGFloat
    let contentPadding: CGFloat
    let metadataSpacing: CGFloat
}

private struct InterfaceDensityEnvironmentKey: EnvironmentKey {
    static let defaultValue = InterfaceDensity.standard
}

extension EnvironmentValues {
    var interfaceDensity: InterfaceDensity {
        get { self[InterfaceDensityEnvironmentKey.self] }
        set { self[InterfaceDensityEnvironmentKey.self] = newValue }
    }
}

extension View {
    func interfaceDensity(_ density: InterfaceDensity) -> some View {
        environment(\.interfaceDensity, density)
    }
}
