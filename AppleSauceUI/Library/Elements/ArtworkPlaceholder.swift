import SwiftUI

/// Neutral generated artwork for examples that do not ship image assets.
struct ArtworkPlaceholder: View {
    @Environment(\.styleProfile) private var styleProfile

    let symbol: String
    let background: AnyShapeStyle
    var cornerRadius: CGFloat?
    var symbolPadding: CGFloat = 38

    var body: some View {
        let resolvedCornerRadius = cornerRadius ?? styleProfile.shapes.artworkCornerRadius

        RoundedRectangle(cornerRadius: resolvedCornerRadius, style: .continuous)
            .fill(background)
            .overlay {
                Image(systemName: symbol)
                    .resizable()
                    .scaledToFit()
                    .padding(symbolPadding)
                    .foregroundStyle(styleProfile.colors.onMedia.opacity(0.9))
                    .symbolRenderingMode(styleProfile.imagery.symbolRenderingMode)
                    .accessibilityHidden(true)
            }
            .clipShape(RoundedRectangle(cornerRadius: resolvedCornerRadius, style: .continuous))
    }
}

#if DEBUG
#Preview("ArtworkPlaceholder — Variants") {
    HStack { ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient)); ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), cornerRadius: 16, symbolPadding: 28) }.padding().frame(width: 402, height: 220)
}
#endif
