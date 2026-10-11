import SwiftUI

/// Neutral generated artwork for examples that do not ship image assets.
struct ArtworkPlaceholder: View {
    let symbol: String
    let background: AnyShapeStyle
    var cornerRadius: CGFloat = 8
    var symbolPadding: CGFloat = 38

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(background)
            .overlay {
                Image(systemName: symbol)
                    .resizable()
                    .scaledToFit()
                    .padding(symbolPadding)
                    .foregroundStyle(.white.opacity(0.9))
                    .accessibilityHidden(true)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

#if DEBUG
#Preview("ArtworkPlaceholder — Variants") {
    HStack { ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient)); ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), cornerRadius: 16, symbolPadding: 28) }.padding().frame(width: 402, height: 220)
}
#endif
