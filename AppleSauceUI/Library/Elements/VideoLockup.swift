import SwiftUI

/// A lightweight landscape-video presentation with a semantic metadata hierarchy.
struct VideoLockup<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let title: String
    var subtitle: String?
    var metadata: String?
    var artworkAspectRatio: CGFloat = 16 / 9
    @ViewBuilder let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: density.metrics.metadataSpacing) {
            artwork
                .aspectRatio(artworkAspectRatio, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay(styleProfile.imagery.overlay)
                .clipShape(artworkShape)
                .overlay {
                    artworkShape.strokeBorder(
                        styleProfile.effects.outlineColor,
                        lineWidth: styleProfile.effects.outlineWidth
                    )
                }
                .shadow(
                    color: styleProfile.effects.standardShadow.color,
                    radius: styleProfile.effects.standardShadow.radius,
                    x: styleProfile.effects.standardShadow.x,
                    y: styleProfile.effects.standardShadow.y
                )
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(styleProfile.typography.itemTitle)
                    .foregroundStyle(styleProfile.colors.primaryText)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                if let subtitle {
                    Text(subtitle)
                        .font(styleProfile.typography.itemSubtitle)
                        .foregroundStyle(styleProfile.colors.secondaryText)
                        .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                }
                if let metadata {
                    Text(metadata)
                        .font(styleProfile.typography.metadata)
                        .foregroundStyle(styleProfile.colors.secondaryText)
                        .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                }
            }
            .accessibilityHidden(true)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
    }

    var accessibilityLabel: String {
        [title, subtitle, metadata]
            .compactMap { $0 }
            .joined(separator: ", ")
    }

    private var artworkShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.artworkCornerRadius, style: .continuous)
    }
}

#if DEBUG
#Preview("VideoLockup — Variants") {
    VStack(spacing: 24) {
        VideoLockup(title: "A Walk Through the City", subtitle: "Field Notes", metadata: "12 min") {
            ArtworkPlaceholder(symbol: "play.rectangle.fill", background: AnyShapeStyle(.indigo.gradient))
        }

        VideoLockup(
            title: "A Longer Video Title That Demonstrates Supported Wrapping",
            subtitle: "A creator name that also grows at accessibility sizes"
        ) {
            ArtworkPlaceholder(symbol: "video.fill", background: AnyShapeStyle(.teal.gradient))
        }
    }
    .padding()
    .frame(width: 334)
}
#endif
