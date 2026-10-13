import SwiftUI

enum PodcastMediaCardRecipes {
    static func episode(
        _ episode: PodcastEpisodeCardFixture,
        playAction: @escaping () -> Void,
        overflowAction: @escaping () -> Void
    ) -> some View {
        MediaCard(
            background: episode.color.gradient,
            contentInsets: EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        ) {
            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                .overlay(alignment: .topTrailing) {
                    if let badge = episode.badge {
                        Label(badge.label, systemImage: "video.fill")
                            .font(.caption2.weight(.semibold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 5)
                            .background(.ultraThinMaterial, in: Capsule())
                            .padding(8)
                            .accessibilityLabel(badge.label)
                    }
                }
                .aspectRatio(PodcastsLayoutMetrics.episodeCardAspectRatio, contentMode: .fit)
        } metadata: {
            VStack(alignment: .leading, spacing: 7) {
                Text(episode.episodeDate)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.72))
                Text(episode.show)
                    .font(.caption.weight(.semibold))
                    .lineLimit(1)
                Text(episode.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(episode.description)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.78))
                    .lineLimit(3)
            }
        } actions: {
            HStack {
                PlaybackButton(
                    label: "Play \(episode.duration)",
                    accessibilityLabel: "Play \(episode.title), \(episode.duration)",
                    action: playAction
                )
                .tint(.white)
                Spacer()
                Button("More", systemImage: "ellipsis", action: overflowAction)
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("More options for \(episode.title)")
            }
            .padding(.top, 7)
        }
    }
}
