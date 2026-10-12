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
    @ViewBuilder let artwork: Artwork

    var body: some View {
        ZStack {
            artwork
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(styleProfile.imagery.overlay)
                .overlay(styleProfile.imagery.scrim)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(styleProfile.typography.heroTitle)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack(alignment: .leading, spacing: density.metrics.metadataSpacing) {
                    if let eyebrow, !eyebrow.isEmpty {
                        Text(eyebrow)
                            .font(styleProfile.typography.eyebrow)
                            .foregroundStyle(styleProfile.colors.onMedia.opacity(0.72))
                    }
                    Text(subtitle)
                        .font(styleProfile.typography.body)
                        .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
                }
            }
            .padding(density.metrics.contentPadding)
        }
        .foregroundStyle(styleProfile.colors.onMedia)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: dynamicTypeSize.isAccessibilitySize ? nil : height, alignment: .topLeading)
        .clipShape(cardShape)
        .overlay { cardShape.stroke(styleProfile.effects.outlineColor, lineWidth: styleProfile.effects.outlineWidth) }
        .shadow(
            color: styleProfile.effects.shadowColor,
            radius: styleProfile.effects.shadowRadius,
            y: styleProfile.effects.shadowRadius / 2
        )
        .accessibilityElement(children: .combine)
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.cardCornerRadius, style: .continuous)
    }
}

#if DEBUG
#Preview("PosterLockup — Variants") {
    PosterLockup(title: "Featured Mix", eyebrow: "Made for You", subtitle: "A collection selected for today", height: 330) {
        Rectangle().fill(.blue.gradient)
    }
    .frame(width: 248)
    .padding()
}


#Preview("PosterLockup — Accessibility") {
    PosterLockup(title: "A Featured Collection With a Long Title", eyebrow: "Made for You", subtitle: "A collection selected for today", height: 330) {
        Rectangle().fill(.blue.gradient)
    }
    .frame(width: 248)
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
