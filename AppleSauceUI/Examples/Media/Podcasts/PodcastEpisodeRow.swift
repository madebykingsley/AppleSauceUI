import SwiftUI

struct PodcastEpisodeRow: View {
    let episode: PodcastEpisodeFixture
    var presentation = EpisodeRowPresentation.compact
    var playAction: () -> Void = {}
    var overflowAction: () -> Void = {}
    var skipForwardAction: () -> Void = {}

    var body: some View {
        EpisodeRow(
            title: episode.title,
            show: episode.show,
            date: episode.episodeDate,
            duration: episode.duration,
            badge: episode.badge?.compactText,
            progress: episode.progress,
            presentation: presentation,
            playAction: playAction,
            overflowAction: overflowAction,
            skipForwardAction: skipForwardAction
        ) {
            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
        }
    }
}

#if DEBUG
#Preview("PodcastEpisodeRow — Variants") {
    VStack {
        PodcastEpisodeRow(episode: PodcastsFixtures.homeMissedEpisodes[0])
        PodcastEpisodeRow(episode: PodcastsFixtures.trendingEpisodes[0], presentation: .featured)
    }
    .padding()
}
#endif
