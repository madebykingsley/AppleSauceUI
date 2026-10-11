import SwiftUI

struct ArtworkThumbnail: View {
    let symbol: String
    let background: AnyShapeStyle
    var size: CGFloat = 40

    var body: some View {
        ArtworkPlaceholder(symbol: symbol, background: background, cornerRadius: 5, symbolPadding: size / 4)
            .frame(width: size, height: size)
    }
}

#if DEBUG
#Preview("ArtworkThumbnail — Variants") {
    HStack { ArtworkThumbnail(symbol: "music.note", background: AnyShapeStyle(.blue.gradient)); ArtworkThumbnail(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), size: 64) }.padding()
}
#endif
