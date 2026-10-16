import SwiftUI

struct ArtworkThumbnail: View {
    @Environment(\.styleProfile) private var styleProfile

    let symbol: String
    let background: AnyShapeStyle
    var size: CGFloat = 40

    var body: some View {
        ArtworkPlaceholder(symbol: symbol, background: background, cornerRadius: 5, symbolPadding: size / 4)
            .frame(width: size, height: size)
            .overlay {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .strokeBorder(
                        styleProfile.effects.outlineColor,
                        lineWidth: styleProfile.effects.outlineWidth
                    )
            }
    }
}

#if DEBUG
#Preview("ArtworkThumbnail — Variants") {
    HStack { ArtworkThumbnail(symbol: "music.note", background: AnyShapeStyle(.blue.gradient)); ArtworkThumbnail(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), size: 64) }.padding()
}
#endif
