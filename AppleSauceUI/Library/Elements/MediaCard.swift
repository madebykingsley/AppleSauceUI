import SwiftUI

struct MediaCard<Background: ShapeStyle, Artwork: View, Details: View>: View {
    let background: Background
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let details: Details

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { artwork; details }
            .foregroundStyle(.white).background(background)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview("MediaCard — Variants") {
    MediaCard(background: .blue.gradient) { Rectangle().fill(.white.opacity(0.15)).aspectRatio(1.6, contentMode: .fit).overlay { Image(systemName: "waveform") } } details: { VStack(alignment: .leading) { Text("Title").font(.headline); Text("Supporting details").font(.caption) }.padding() }.padding().frame(width: 402)
}
#endif
