import SwiftUI

/// A portrait, full-bleed artwork presentation used by featured media.
struct PosterLockup<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let title: String
    var eyebrow: String?
    let subtitle: String
    let height: CGFloat
    var elevation: ElementElevation = .standard
    @ViewBuilder let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(styleProfile.typography.heroTitle)
                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack(alignment: .leading, spacing: density.metrics.metadataSpacing) {
                if let eyebrow, !eyebrow.isEmpty {
                    Text(eyebrow)
                        .font(styleProfile.typography.heroEyebrow)
                        .foregroundStyle(styleProfile.colors.onMedia.opacity(0.72))
                }
                Text(subtitle)
                    .font(styleProfile.typography.heroSupporting)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
            }
        }
        .padding(density.metrics.prominentContentPadding)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: dynamicTypeSize.isAccessibilitySize ? nil : height, alignment: .topLeading)
        .background {
            ArtworkContainer(
                geometry: .minimumHeight(height),
                clipShape: cardShape
            ) {
                artwork
            } decoration: {
                Rectangle().fill(styleProfile.imagery.treatment(.textLegibility))
            }
                .accessibilityHidden(true)
        }
        .foregroundStyle(styleProfile.colors.onMedia)
        .clipShape(cardShape)
        .overlay { cardShape.stroke(styleProfile.effects.outlineColor, lineWidth: styleProfile.effects.outlineWidth) }
        .shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
        .accessibilityElement(children: .combine)
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.cardCornerRadius, style: .continuous)
    }

    private var shadow: StyleProfileShadow {
        styleProfile.effects.shadow(for: elevation)
    }
}

#if DEBUG
#Preview("PosterLockup — Variants") {
    PosterLockup(title: "The Curiosity Archive", eyebrow: "Featured Collection", subtitle: "Stories gathered after dark", height: 330) {
        ArtworkImage(assetName: "RegressionPortraitArtwork", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.indigo.gradient))
    }
    .frame(width: 248)
    .padding()
}


#Preview("PosterLockup — Accessibility") {
    PosterLockup(title: "The Curiosity Archive: A Featured Collection With a Long Title", eyebrow: "Featured Collection", subtitle: "Stories gathered after dark", height: 330) {
        ArtworkImage(assetName: "RegressionPortraitArtwork", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.indigo.gradient))
    }
    .frame(width: 248)
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
