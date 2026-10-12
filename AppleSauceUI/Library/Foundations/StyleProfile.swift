import SwiftUI

/// A coherent visual language applied independently from view structure and behavior.
enum StyleProfile: String, CaseIterable, Identifiable, Sendable {
    case editorial
    case entertainment
    case neutral

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .editorial: "Editorial"
        case .entertainment: "Entertainment"
        case .neutral: "Neutral"
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch self {
        case .entertainment: .dark
        case .editorial, .neutral: nil
        }
    }

    var typography: StyleProfileTypography {
        switch self {
        case .editorial:
            StyleProfileTypography(
                heroTitle: .system(.largeTitle, design: .serif, weight: .semibold),
                sectionTitle: .system(.title2, design: .serif, weight: .semibold),
                prominentSectionTitle: .system(.title2, design: .serif, weight: .bold),
                contentTitle: .system(.title3, design: .serif, weight: .semibold),
                body: .system(.callout, design: .serif),
                eyebrow: .system(.caption2, design: .serif, weight: .semibold),
                itemTitle: .system(.footnote, design: .serif, weight: .semibold),
                metadata: .system(.caption2, design: .serif)
            )
        case .entertainment:
            StyleProfileTypography(
                heroTitle: .largeTitle.weight(.bold),
                sectionTitle: .title2.weight(.bold),
                prominentSectionTitle: .title2.weight(.heavy),
                contentTitle: .title3.weight(.bold),
                body: .callout,
                eyebrow: .caption2.weight(.bold),
                itemTitle: .footnote.weight(.bold),
                metadata: .caption2.weight(.medium)
            )
        case .neutral:
            StyleProfileTypography(
                heroTitle: .largeTitle.weight(.semibold),
                sectionTitle: .title3.weight(.semibold),
                prominentSectionTitle: .title2.bold(),
                contentTitle: .headline,
                body: .subheadline,
                eyebrow: .caption2.weight(.semibold),
                itemTitle: .footnote.weight(.medium),
                metadata: .caption2
            )
        }
    }

    var colors: StyleProfileColors {
        switch self {
        case .editorial:
            StyleProfileColors(
                primaryText: .primary,
                secondaryText: .secondary,
                onMedia: .white,
                accent: .brown,
                surface: AnyShapeStyle(.background)
            )
        case .entertainment:
            StyleProfileColors(
                primaryText: .white,
                secondaryText: .white.opacity(0.72),
                onMedia: .white,
                accent: .purple,
                surface: AnyShapeStyle(.black)
            )
        case .neutral:
            StyleProfileColors(
                primaryText: .primary,
                secondaryText: .secondary,
                onMedia: .white,
                accent: .accentColor,
                surface: AnyShapeStyle(.background)
            )
        }
    }

    var shapes: StyleProfileShapes {
        switch self {
        case .editorial: StyleProfileShapes(artworkCornerRadius: 2, cardCornerRadius: 4)
        case .entertainment: StyleProfileShapes(artworkCornerRadius: 16, cardCornerRadius: 20)
        case .neutral: StyleProfileShapes(artworkCornerRadius: 8, cardCornerRadius: 12)
        }
    }

    var imagery: StyleProfileImagery {
        switch self {
        case .editorial:
            StyleProfileImagery(
                overlay: AnyShapeStyle(Color.clear),
                scrim: AnyShapeStyle(.black.opacity(0.38).gradient),
                symbolRenderingMode: .monochrome
            )
        case .entertainment:
            StyleProfileImagery(
                overlay: AnyShapeStyle(
                    LinearGradient(
                        colors: [.clear, .purple.opacity(0.28)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                ),
                scrim: AnyShapeStyle(.black.opacity(0.58).gradient),
                symbolRenderingMode: .hierarchical
            )
        case .neutral:
            StyleProfileImagery(
                overlay: AnyShapeStyle(Color.clear),
                scrim: AnyShapeStyle(.black.opacity(0.46).gradient),
                symbolRenderingMode: .monochrome
            )
        }
    }

    var effects: StyleProfileEffects {
        switch self {
        case .editorial:
            StyleProfileEffects(outlineColor: .secondary.opacity(0.28), outlineWidth: 1, shadowColor: .clear, shadowRadius: 0, chromeProminence: .subtle, standardMotionDuration: 0.2)
        case .entertainment:
            StyleProfileEffects(outlineColor: .clear, outlineWidth: 0, shadowColor: .black.opacity(0.35), shadowRadius: 10, chromeProminence: .expressive, standardMotionDuration: 0.35)
        case .neutral:
            StyleProfileEffects(outlineColor: .secondary.opacity(0.16), outlineWidth: 0.5, shadowColor: .black.opacity(0.12), shadowRadius: 3, chromeProminence: .standard, standardMotionDuration: 0.25)
        }
    }
}

struct StyleProfileTypography {
    /// Typography for the primary title in a hero-level content presentation.
    let heroTitle: Font
    let sectionTitle: Font
    let prominentSectionTitle: Font
    let contentTitle: Font
    let body: Font
    let eyebrow: Font
    let itemTitle: Font
    let metadata: Font
}

struct StyleProfileColors {
    let primaryText: Color
    let secondaryText: Color
    let onMedia: Color
    let accent: Color
    let surface: AnyShapeStyle
}

struct StyleProfileShapes {
    let artworkCornerRadius: CGFloat
    let cardCornerRadius: CGFloat
}

struct StyleProfileImagery {
    let overlay: AnyShapeStyle
    let scrim: AnyShapeStyle
    let symbolRenderingMode: SymbolRenderingMode
}

enum StyleProfileChromeProminence {
    case subtle
    case standard
    case expressive
}

struct StyleProfileEffects {
    let outlineColor: Color
    let outlineWidth: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    let chromeProminence: StyleProfileChromeProminence
    let standardMotionDuration: TimeInterval
}

private struct StyleProfileEnvironmentKey: EnvironmentKey {
    static let defaultValue = StyleProfile.neutral
}

extension EnvironmentValues {
    var styleProfile: StyleProfile {
        get { self[StyleProfileEnvironmentKey.self] }
        set { self[StyleProfileEnvironmentKey.self] = newValue }
    }
}

extension View {
    /// Applies a visual language without changing the subtree's structure or content.
    func styleProfile(_ profile: StyleProfile, honorsPreferredColorScheme: Bool = true) -> some View {
        environment(\.styleProfile, profile)
            .tint(profile.colors.accent)
            .preferredColorScheme(honorsPreferredColorScheme ? profile.preferredColorScheme : nil)
    }
}
