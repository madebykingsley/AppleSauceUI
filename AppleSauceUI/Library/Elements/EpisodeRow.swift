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
}

struct EpisodeRow<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    let title: String
    let show: String
    let date: String
    let duration: String
    var badge: String?
    var progress: Double?
    var presentation = EpisodeRowPresentation.compact
    let playAction: () -> Void
    let overflowAction: () -> Void
    let skipForwardAction: () -> Void
    @ViewBuilder let artwork: Artwork

    var body: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    episodeArtwork
                    metadata.frame(maxWidth: .infinity, alignment: .leading)
                }
                controls.frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(spacing: 12) {
                episodeArtwork
                metadata.frame(maxWidth: .infinity, alignment: .leading)
                controls
            }
        }
    }

    private var episodeArtwork: some View {
        artwork
            .frame(width: presentation.artworkSize, height: presentation.artworkSize)
            .accessibilityHidden(true)
    }

    private var metadata: some View {
        VStack(alignment: .leading, spacing: 2) {
            if presentation == .featured {
                Text(show).font(.caption.weight(.semibold)).foregroundStyle(.primary).lineLimit(1)
            } else {
                Text(date).font(.caption2).foregroundStyle(.secondary)
            }

            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
                .lineLimit(presentation == .recentlyPlayed ? 1 : 2)

            if presentation == .featured {
                HStack(spacing: 4) {
                    Text(date)
                    Text("·")
                    Text(duration)
                    if let badge { MetadataBadge(label: badge) }
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            } else if presentation == .recentlyPlayed {
                Text(show).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                if let progress {
                    ProgressView(value: progress)
                        .accessibilityLabel("Playback progress")
                        .accessibilityValue("\(Int(progress * 100)) percent")
                }
            }
        }
    }
    @ViewBuilder private var controls: some View {
        switch presentation {
        case .compact:
            HStack(spacing: 12) {
                PlaybackButton(label: "Play \(duration)", accessibilityLabel: "Play \(title), \(duration)", action: playAction)
                moreButton
            }
        case .featured:
            moreButton
        case .recentlyPlayed:
            HStack(spacing: 12) {
                Button("Play \(title)", systemImage: "play.fill", action: playAction).labelStyle(.iconOnly)
                Button("Skip forward 30 seconds", systemImage: "goforward.30", action: skipForwardAction).labelStyle(.iconOnly)
            }
        }
    }

    private var moreButton: some View {
        Button("More", systemImage: "ellipsis", action: overflowAction)
            .labelStyle(.iconOnly)
            .accessibilityLabel("More options for \(title)")
    }
}

#if DEBUG
#Preview("EpisodeRow — Variants") {
    VStack(spacing: 16) {
        EpisodeRow(title: "An Everyday Story", show: "Daily Stories", date: "Today", duration: "24 min", badge: "E", presentation: .compact, playAction: {}, overflowAction: {}, skipForwardAction: {}) { ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(.indigo.gradient), symbolPadding: 16) }
        EpisodeRow(title: "A Longer Episode Title That Demonstrates Wrapping", show: "Field Notes", date: "Yesterday", duration: "38 min", badge: nil, presentation: .featured, playAction: {}, overflowAction: {}, skipForwardAction: {}) { ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.orange.gradient), symbolPadding: 12) }
        EpisodeRow(title: "Recently Played", show: "Ideas Weekly", date: "Friday", duration: "52 min", badge: nil, progress: 0.4, presentation: .recentlyPlayed, playAction: {}, overflowAction: {}, skipForwardAction: {}) { ArtworkPlaceholder(symbol: "headphones", background: AnyShapeStyle(.teal.gradient), symbolPadding: 10) }
    }.padding().frame(width: 480)
}

#Preview("EpisodeRow — Accessibility") {
    ScrollView { EpisodeRow(title: "A Long Episode Title at an Accessibility Text Size", show: "Daily Stories", date: "Today", duration: "24 min", badge: "E", presentation: .compact, playAction: {}, overflowAction: {}, skipForwardAction: {}) { ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(.indigo.gradient), symbolPadding: 16) }.padding() }.dynamicTypeSize(.accessibility3).frame(width: 402)
}
#endif
