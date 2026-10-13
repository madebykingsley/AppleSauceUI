import SwiftUI

struct EditorialHero<Artwork: View>: View {
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
                    .lineLimit(2)
            }
            artwork
                .aspectRatio(1.5, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
        }
        .accessibilityElement(children: .combine)
    }

    private var shadow: StyleProfileShadow {
        styleProfile.effects.shadow(for: elevation)
    }
}

#if DEBUG
#Preview("EditorialHero — Variants") {
    EditorialHero(eyebrow: "Editors’ Choice", title: "A closer look at new voices") { RoundedRectangle(cornerRadius: 12).fill(.orange.gradient).overlay { Image(systemName: "sparkles").font(.largeTitle) } }.padding().frame(width: 402)
}

#Preview("EditorialHero — Accessibility") {
    EditorialHero(
        eyebrow: "Editors’ Choice",
        title: "A closer look at the new voices shaping music and culture"
    ) {
        RoundedRectangle(cornerRadius: 12)
            .fill(.orange.gradient)
            .overlay { Image(systemName: "sparkles").font(.largeTitle) }
    }
    .padding()
    .frame(width: 402)
    .dynamicTypeSize(.accessibility3)
}
#endif
