import SwiftUI

/// A landscape card for a playable audio or video episode.
struct EpisodeCard<Background: ShapeStyle, Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let date: String
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
                    .font(styleProfile.typography.emphasizedMetadata)
                    .foregroundStyle(styleProfile.colors.onMedia.opacity(0.72))
                episodeText
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text(verbatim: accessibilityMetadataLabel))
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
            .padding(.top, density.metrics.metadataActionSpacing)
        }
    }

    @ViewBuilder private var episodeText: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: density.metrics.metadataSpacing / 2) {
                titleText
                summaryText
            }
        } else {
            Text(verbatim: " \n \n \n ")
                .font(styleProfile.typography.contentTitle)
                .hidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: density.metrics.metadataSpacing / 2) {
                        titleText
                            .lineLimit(4)
                            .layoutPriority(1)
                        summaryText
                            .lineLimit(3)
                    }
                }
                .clipped()
        }
    }

    private var titleText: some View {
        Text(episodeTitle)
            .font(styleProfile.typography.contentTitle)
    }

    @ViewBuilder private var summaryText: some View {
        if let summary, !summary.isEmpty {
            Text(summary)
                .font(styleProfile.typography.body)
                .foregroundStyle(styleProfile.colors.onMedia.opacity(0.78))
        }
    }

    private let artworkAspectRatio: CGFloat = 1.65

    var accessibilityMetadataLabel: String {
        [date, episodeTitle, summary, mediaBadgeAccessibilityLabel ?? mediaBadge]
            .compactMap { value in
                guard let value, !value.isEmpty else {
                    return nil
                }
                return value
            }
            .joined(separator: ", ")
    }
}

#if DEBUG
#Preview("EpisodeCard — Variants") {
    ScrollView(.horizontal) {
        HStack(alignment: .top, spacing: 16) {
            EpisodeCard(
                date: "New · Sep 19",
                episodeTitle: "A conversation worth hearing",
                summary: "A thoughtful discussion about creativity and the people behind it.",
                duration: "33m",
                mediaBadge: "Video",
                background: Color.teal.gradient
            ) {
                ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(Color.teal.gradient))
            }
            .frame(width: 249)

            EpisodeCard(
                date: "Yesterday",
                episodeTitle: "A longer episode title that needs several lines before its summary",
                summary: "Only the remaining lines are available here.",
                duration: "48m",
                background: Color.indigo.gradient
            ) {
                ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(Color.indigo.gradient))
            }
            .frame(width: 249)

            EpisodeCard(
                date: "Oct 12",
                episodeTitle: "Four lines of title content can consume the entire shared text region and omit the summary from the visible card",
                summary: "This summary remains available to accessibility technologies.",
                duration: "1h 12m",
                background: Color.orange.gradient
            ) {
                ArtworkPlaceholder(symbol: "headphones", background: AnyShapeStyle(Color.orange.gradient))
            }
            .frame(width: 249)
        }
        .padding()
    }
    .frame(height: 430)
    .frame(width: 800)
    .environment(\.interfaceDensity, .standard)
}

#Preview("EpisodeCard — Accessibility") {
    EpisodeCard(
        date: "Today",
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
