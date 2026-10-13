import SwiftUI

struct MusicVideoLockup: View {
    let item: MusicItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                .aspectRatio(MusicLayoutMetrics.videoArtworkAspectRatio, contentMode: .fit)
            VStack(alignment: .leading, spacing: 1) {
                Text(item.title)
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text(item.subtitle)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("MusicVideoLockup") {
    MusicVideoLockup(item: MusicFixtures.interviews[0])
        .frame(width: MusicLayoutMetrics.albumWidth)
        .padding()
}
#endif
