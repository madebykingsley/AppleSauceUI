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
                heroEyebrow: .system(.caption2, design: .serif, weight: .semibold),
                heroSupporting: .system(.callout, design: .serif),
                sectionTitle: .system(.title2, design: .serif, weight: .semibold),
                prominentSectionTitle: .system(.title2, design: .serif, weight: .bold),
                contentTitle: .system(.title3, design: .serif, weight: .semibold),
                prominentContentTitle: .system(.title2, design: .serif, weight: .semibold),
                body: .system(.callout, design: .serif),
                eyebrow: .system(.caption2, design: .serif, weight: .semibold),
                itemTitle: .system(.footnote, design: .serif, weight: .semibold),
                itemSubtitle: .system(.footnote, design: .serif),
                metadata: .system(.caption2, design: .serif)
            )
        case .entertainment:
            StyleProfileTypography(
                heroTitle: .largeTitle.weight(.bold),
                heroEyebrow: .callout.weight(.bold),
                heroSupporting: .callout,
                sectionTitle: .title2.weight(.bold),
                prominentSectionTitle: .title2.weight(.heavy),
                contentTitle: .title3.weight(.bold),
                prominentContentTitle: .title2.weight(.bold),
                body: .callout,
                eyebrow: .caption2.weight(.bold),
                itemTitle: .footnote.weight(.bold),
                itemSubtitle: .footnote.weight(.medium),
                metadata: .caption2.weight(.medium)
            )
        case .neutral:
            StyleProfileTypography(
                heroTitle: .largeTitle.weight(.semibold),
                heroEyebrow: .footnote,
                heroSupporting: .footnote,
                sectionTitle: .title3.weight(.semibold),
                prominentSectionTitle: .title2.bold(),
                contentTitle: .headline,
                prominentContentTitle: .title3,
                body: .subheadline,
                eyebrow: .caption2.weight(.semibold),
                itemTitle: .footnote.weight(.medium),
                itemSubtitle: .footnote,
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
                scrim: AnyShapeStyle(.black.opacity(0.38).gradient),
                symbolRenderingMode: .monochrome
            )
        case .entertainment:
            StyleProfileImagery(
                scrim: AnyShapeStyle(.black.opacity(0.58).gradient),
                symbolRenderingMode: .hierarchical
            )
        case .neutral:
            StyleProfileImagery(
                scrim: AnyShapeStyle(.black.opacity(0.46).gradient),
                symbolRenderingMode: .monochrome
            )
        }
    }

    var effects: StyleProfileEffects {
        switch self {
        case .editorial:
            StyleProfileEffects(
                outlineColor: .primary.opacity(0.22),
                outlineWidth: 0.5,
                subtleShadow: .none,
                standardShadow: .none,
                prominentShadow: StyleProfileShadow(color: .black.opacity(0.24), radius: 10, x: 0, y: 4),
                chromeProminence: .subtle,
                standardMotionDuration: 0.2
            )
        case .entertainment:
            StyleProfileEffects(
                outlineColor: .white.opacity(0.22),
                outlineWidth: 0.5,
                subtleShadow: StyleProfileShadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2.5),
                standardShadow: StyleProfileShadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 5),
                prominentShadow: StyleProfileShadow(color: .black.opacity(0.38), radius: 20, x: 0, y: 10),
                chromeProminence: .expressive,
                standardMotionDuration: 0.35
            )
        case .neutral:
            StyleProfileEffects(
                outlineColor: .primary.opacity(0.22),
                outlineWidth: 0.5,
                subtleShadow: StyleProfileShadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1),
                standardShadow: StyleProfileShadow(color: .black.opacity(0.12), radius: 3, x: 0, y: 1.5),
                prominentShadow: StyleProfileShadow(color: .black.opacity(0.22), radius: 14, x: 0, y: 7),
                chromeProminence: .standard,
                standardMotionDuration: 0.25
            )
        }
    }
}

struct StyleProfileTypography {
    /// Typography for the primary title in a hero-level content presentation.
    let heroTitle: Font
    /// Typography for a short label that qualifies hero-level content.
    let heroEyebrow: Font
    /// Typography for supporting information within hero-level content.
    let heroSupporting: Font
    let sectionTitle: Font
    let prominentSectionTitle: Font
    let contentTitle: Font
    let prominentContentTitle: Font
    let body: Font
    let eyebrow: Font
    let itemTitle: Font
    let itemSubtitle: Font
    let metadata: Font

    /// Typography for metadata that needs stronger emphasis, such as a date or status.
    var emphasizedMetadata: Font { metadata.weight(.semibold) }
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
    let scrim: AnyShapeStyle
    let symbolRenderingMode: SymbolRenderingMode

    func treatment(_ treatment: ArtworkTreatment) -> AnyShapeStyle {
        switch treatment {
        case .unmodified:
            AnyShapeStyle(Color.clear)
        case .textLegibility:
            scrim
        }
    }
}

enum StyleProfileChromeProminence {
    case subtle
    case standard
    case expressive
}

struct StyleProfileEffects {
    let outlineColor: Color
    let outlineWidth: CGFloat
    let subtleShadow: StyleProfileShadow
    let standardShadow: StyleProfileShadow
    let prominentShadow: StyleProfileShadow
    let chromeProminence: StyleProfileChromeProminence
    let standardMotionDuration: TimeInterval

    func shadow(for elevation: ElementElevation) -> StyleProfileShadow {
        switch elevation {
        case .none: .none
        case .subtle: subtleShadow
        case .standard: standardShadow
        case .prominent: prominentShadow
        }
    }
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
