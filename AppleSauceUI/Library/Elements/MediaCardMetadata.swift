import SwiftUI

/// Semantic text anatomy shared by the standard and overlay MediaCard layouts.
struct MediaCardMetadata: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let layout: MediaCardLayout
    var eyebrow: String?
    let title: String
    var subtitle: String?
    var metadata: String?
    var badge: String?
    var badgeAccessibilityLabel: String?

    var body: some View {
        VStack(alignment: .leading, spacing: density.metrics.metadataSpacing / 2) {
            if eyebrow != nil || badge != nil {
                HStack(alignment: .firstTextBaseline, spacing: density.metrics.metadataSpacing) {
                    if let eyebrow {
                        Text(eyebrow)
                            .font(styleProfile.typography.eyebrow)
                            .textCase(.uppercase)
                    }
                    Spacer(minLength: 0)
                    if let badge {
                        MetadataBadge(
                            label: badge,
                            accessibilityLabel: badgeAccessibilityLabel,
                            context: layout == .overlay ? .onMedia : .standard
                        )
                    }
                }
                .foregroundStyle(secondaryForeground)
            }

            Text(title)
                .font(styleProfile.typography.contentTitle)
                .foregroundStyle(primaryForeground)
                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)

            if let subtitle {
                Text(subtitle)
                    .font(styleProfile.typography.body)
                    .foregroundStyle(secondaryForeground)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
            }

            if let metadata {
                Text(metadata)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(secondaryForeground)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
            }
        }
    }

    private var primaryForeground: Color {
        layout == .overlay ? styleProfile.colors.onMedia : styleProfile.colors.primaryText
    }

    private var secondaryForeground: Color {
        layout == .overlay ? styleProfile.colors.onMedia.opacity(0.76) : styleProfile.colors.secondaryText
    }
}
