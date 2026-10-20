import SwiftUI

struct EditorialHero<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.styleProfile) private var styleProfile

    let eyebrow: LocalizedStringKey
    let title: LocalizedStringKey
    var elevation: ElementElevation = .standard
    @ViewBuilder let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text(eyebrow)
                    .font(styleProfile.typography.eyebrow)
                    .foregroundStyle(styleProfile.colors.secondaryText)
                    .textCase(.uppercase)
                Text(title)
                    .font(styleProfile.typography.prominentContentTitle)
                    .foregroundStyle(styleProfile.colors.primaryText)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
            }
            ArtworkContainer(
                geometry: .aspectRatio(1.5),
                clipShape: artworkShape
            ) {
                artwork
            }
                .overlay {
                    artworkShape.strokeBorder(
                        styleProfile.effects.outlineColor,
                        lineWidth: styleProfile.effects.outlineWidth
                    )
                }
                .shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
        }
        .accessibilityElement(children: .combine)
    }

    private var shadow: StyleProfileShadow {
        styleProfile.effects.shadow(for: elevation)
    }

    private var artworkShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.artworkCornerRadius, style: .continuous)
    }
}

#if DEBUG
#Preview("EditorialHero — Variants") {
    EditorialHero(eyebrow: "Editors’ Choice", title: "A closer look at coastal communities") {
        ArtworkImage(assetName: "EpisodeCoastalTrail", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.orange.gradient))
    }
    .padding()
    .frame(width: 402)
}

#Preview("EditorialHero — Accessibility") {
    EditorialHero(
        eyebrow: "Editors’ Choice",
        title: "A closer look at the new voices shaping music and culture"
    ) {
        ArtworkImage(assetName: "EpisodeCoastalTrail", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.orange.gradient))
    }
    .padding()
    .frame(width: 402)
    .dynamicTypeSize(.accessibility3)
}
#endif
