import SwiftUI

struct MusicFeaturedLockup: View {
    let item: MusicItem

    var body: some View {
        PosterLockup(
            title: item.title,
            eyebrow: item.eyebrow,
            subtitle: item.subtitle,
            height: MusicLayoutMetrics.featureHeight,
            elevation: .prominent
        ) {
            Rectangle().fill(item.artwork.gradient)
        }
    }
}

#if DEBUG
#Preview("MusicFeaturedLockup") {
    MusicFeaturedLockup(item: MusicFixtures.topPicks[0])
        .frame(width: MusicLayoutMetrics.featureWidth)
        .padding()
}
#endif
