import SwiftUI

enum EpisodeRowPresentation: Equatable {
    case compact
    case featured
    case recentlyPlayed

    var artworkSize: CGFloat {
        switch self {
        case .compact: 64
        case .featured: 48
        case .recentlyPlayed: 44
        }
    }

    var separatorInset: CGFloat { artworkSize + 12 }
    var verticalPadding: CGFloat { 8 }
}

struct EpisodeRow<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.styleProfile) private var styleProfile

    let title: String
    let show: String
    let date: String
    let duration: String
    var badge: String?
    var progress: Double?
    var presentation = EpisodeRowPresentation.compact
    let playAction: () -> Void
    let overflowAction: () -> Void
    @ViewBuilder let artwork: Artwork

    var body: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: 12) {
                episodeArtwork
                content
            }
            .padding(.vertical, presentation.verticalPadding)
        } else {
            HStack(alignment: .top, spacing: 12) {
                episodeArtwork
                content
            }
            .padding(.vertical, presentation.verticalPadding)
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            metadata.frame(maxWidth: .infinity, alignment: .leading)
            controls
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var episodeArtwork: some View {
        artwork
            .frame(width: presentation.artworkSize, height: presentation.artworkSize)
            .overlay(styleProfile.imagery.overlay)
            .clipShape(artworkShape)
            .shadow(
                color: styleProfile.effects.standardShadow.color,
                radius: styleProfile.effects.standardShadow.radius,
                x: styleProfile.effects.standardShadow.x,
                y: styleProfile.effects.standardShadow.y
            )
            .accessibilityHidden(true)
    }

    private var artworkShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.artworkCornerRadius, style: .continuous)
    }

    private var metadata: some View {
        VStack(alignment: .leading, spacing: 2) {
            if presentation == .featured {
                Text(show)
                    .font(styleProfile.typography.itemTitle)
                    .foregroundStyle(styleProfile.colors.primaryText)
                    .lineLimit(1)
            } else {
                Text(date)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(styleProfile.colors.secondaryText)
            }

            Text(title)
                .font(styleProfile.typography.body)
                .foregroundStyle(styleProfile.colors.primaryText)
                .lineLimit(presentation == .recentlyPlayed ? 1 : 2)

            if presentation == .featured {
                HStack(spacing: 4) {
                    Text(date)
                    Text("·")
                    Text(duration)
                    if let badge { MetadataBadge(label: badge) }
                }
                .font(styleProfile.typography.metadata)
                .foregroundStyle(styleProfile.colors.secondaryText)
            } else if presentation == .recentlyPlayed {
                Text(show)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(styleProfile.colors.secondaryText)
                    .lineLimit(1)
            }
        }
    }

    private var controls: some View {
        HStack {
            PlaybackButton(
                label: duration,
                accessibilityLabel: "Play \(title), \(duration)",
                progress: presentation == .recentlyPlayed ? progress : nil,
                action: playAction
            )
            Spacer()
            moreButton
        }
        .frame(maxWidth: .infinity)
    }

    private var moreButton: some View {
        Button("More", systemImage: "ellipsis", action: overflowAction)
            .labelStyle(.iconOnly)
            .buttonStyle(.plain)
            .foregroundStyle(styleProfile.colors.secondaryText)
            .accessibilityLabel("More options for \(title)")
    }
}

#if DEBUG
#Preview("EpisodeRow — Compact") {
    EpisodeRow(title: "An Everyday Story", show: "Daily Stories", date: "Today", duration: "24 min", badge: "E", presentation: .compact, playAction: {}, overflowAction: {}) {
        ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(.indigo.gradient), symbolPadding: 16)
    }
    .padding()
}

#Preview("EpisodeRow — Featured") {
    EpisodeRow(title: "A Longer Episode Title That Demonstrates Wrapping", show: "Field Notes", date: "Yesterday", duration: "38 min", badge: nil, presentation: .featured, playAction: {}, overflowAction: {}) {
        ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.orange.gradient), symbolPadding: 12)
    }
    .padding()
}

#Preview("EpisodeRow — Recently Played") {
    EpisodeRow(title: "Recently Played", show: "Ideas Weekly", date: "Friday", duration: "52 min", badge: nil, progress: 0.4, presentation: .recentlyPlayed, playAction: {}, overflowAction: {}) {
        ArtworkPlaceholder(symbol: "headphones", background: AnyShapeStyle(.teal.gradient), symbolPadding: 10)
    }
    .padding()
}

#Preview("EpisodeRow — Accessibility") {
    ScrollView {
        EpisodeRow(title: "A Long Episode Title at an Accessibility Text Size", show: "Daily Stories", date: "Today", duration: "24 min", badge: "E", presentation: .compact, playAction: {}, overflowAction: {}) {
            ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(.indigo.gradient), symbolPadding: 16)
        }
        .padding()
    }
    .dynamicTypeSize(.accessibility3)
}
#endif
