import SwiftUI

struct MusicArtworkLockup: View {
    let item: MusicItem
    var symbolPadding: CGFloat = 38

    var body: some View {
        SquareLockup(title: item.title, subtitle: item.subtitle) {
            ArtworkPlaceholder(
                symbol: item.symbol,
                background: AnyShapeStyle(item.artwork.gradient),
                symbolPadding: symbolPadding
            )
        }
    }
}

#if DEBUG
#Preview("MusicArtworkLockup") {
    MusicArtworkLockup(item: MusicFixtures.recentlyPlayed[0])
        .frame(width: MusicLayoutMetrics.albumWidth)
        .padding()
}
#endif
