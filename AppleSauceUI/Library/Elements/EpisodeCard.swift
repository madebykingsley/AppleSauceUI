import SwiftUI

/// A landscape card for a playable audio or video episode.
struct EpisodeCard<Background: ShapeStyle, Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let date: String
    let showTitle: String
    let episodeTitle: String
    var summary: String?
    let duration: String
    var mediaBadge: String?
    var mediaBadgeAccessibilityLabel: String?
    var mediaBadgeSystemImage = "video.fill"
    let background: Background
    var playAction: () -> Void = {}
    var overflowAction: () -> Void = {}
    @ViewBuilder let artwork: Artwork

    var body: some View {
        MediaCard(background: background) {
            artwork
                .overlay(alignment: .topTrailing) {
                    if let mediaBadge {
                        Label(mediaBadge, systemImage: mediaBadgeSystemImage)
                            .font(styleProfile.typography.metadata.weight(.semibold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 5)
                            .background(.ultraThinMaterial, in: Capsule())
                            .padding(8)
                            .accessibilityLabel(mediaBadgeAccessibilityLabel ?? mediaBadge)
                    }
                }
                .aspectRatio(artworkAspectRatio, contentMode: .fit)
                .accessibilityHidden(true)
        } metadata: {
            VStack(alignment: .leading, spacing: density.metrics.metadataSpacing / 2) {
                Text(date)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(styleProfile.colors.onMedia.opacity(0.72))
                Text(showTitle)
                    .font(styleProfile.typography.eyebrow)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                Text(episodeTitle)
                    .font(styleProfile.typography.contentTitle)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
                if let summary, !summary.isEmpty {
                    Text(summary)
                        .font(styleProfile.typography.body)
                        .foregroundStyle(styleProfile.colors.onMedia.opacity(0.78))
                        .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
                }
            }
            .accessibilityElement(children: .combine)
        } actions: {
            HStack {
                PlaybackButton(
                    label: duration,
                    accessibilityLabel: "Play \(episodeTitle), \(duration)",
                    action: playAction
                )
                .tint(styleProfile.colors.onMedia)
                Spacer()
                Button("More", systemImage: "ellipsis", action: overflowAction)
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("More options for \(episodeTitle)")
            }
            .padding(.top, density.metrics.metadataSpacing / 2)
        }
    }

    private let artworkAspectRatio: CGFloat = 1.65
}

#if DEBUG
#Preview("EpisodeCard — Variants") {
    EpisodeCard(
        date: "New · Sep 19",
        showTitle: "Daily Stories",
        episodeTitle: "A conversation worth hearing",
        summary: "A thoughtful discussion about creativity and the people behind it.",
        duration: "33m",
        mediaBadge: "Video",
        background: Color.teal.gradient
    ) {
        ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(Color.teal.gradient))
    }
    .frame(width: 249)
    .padding()
}

#Preview("EpisodeCard — Accessibility") {
    EpisodeCard(
        date: "Today",
        showTitle: "A Show With an Intentionally Long Name",
        episodeTitle: "An Episode Title Long Enough to Exercise the Card Layout",
        summary: "A longer description verifies that the card grows coherently with Dynamic Type.",
        duration: "1h 48m",
        background: Color.indigo.gradient
    ) {
        ArtworkPlaceholder(symbol: "text.bubble.fill", background: AnyShapeStyle(Color.indigo.gradient))
    }
    .frame(width: 249)
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
