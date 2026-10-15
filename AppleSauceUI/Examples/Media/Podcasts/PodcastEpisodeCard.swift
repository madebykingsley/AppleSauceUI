import SwiftUI

struct PodcastEpisodeCard: View {
    @Environment(\.styleProfile) private var styleProfile

    let episode: PodcastEpisodeCardFixture
    var playAction: () -> Void = {}
    var overflowAction: () -> Void = {}

    var body: some View {
        MediaCard(
            background: episode.color.gradient,
            contentInsets: EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        ) {
            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                .overlay(alignment: .topTrailing) {
                    if let badge = episode.badge {
                        Label(badge.label, systemImage: "video.fill")
                            .font(styleProfile.typography.metadata.weight(.semibold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 5)
                            .background(.ultraThinMaterial, in: Capsule())
                            .padding(8)
                            .accessibilityLabel(badge.label)
                    }
                }
                .aspectRatio(artworkAspectRatio, contentMode: .fit)
        } metadata: {
            VStack(alignment: .leading, spacing: 7) {
                Text(episode.episodeDate)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(styleProfile.colors.onMedia.opacity(0.72))
                Text(episode.show)
                    .font(styleProfile.typography.eyebrow)
                    .lineLimit(1)
                Text(episode.title)
                    .font(styleProfile.typography.contentTitle)
                    .lineLimit(2)
                Text(episode.description)
                    .font(styleProfile.typography.body)
                    .foregroundStyle(styleProfile.colors.onMedia.opacity(0.78))
                    .lineLimit(3)
            }
        } actions: {
            HStack {
                PlaybackButton(
                    label: "Play \(episode.duration)",
                    accessibilityLabel: "Play \(episode.title), \(episode.duration)",
                    action: playAction
                )
                .tint(styleProfile.colors.onMedia)
                Spacer()
                Button("More", systemImage: "ellipsis", action: overflowAction)
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("More options for \(episode.title)")
            }
            .padding(.top, 7)
        }
    }

    private let artworkAspectRatio: CGFloat = 1.1
}

#if DEBUG
#Preview("PodcastEpisodeCard") {
    PodcastEpisodeCard(episode: PodcastsFixtures.upNextCards[0])
        .frame(width: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard))
        .padding()
}
#endif
