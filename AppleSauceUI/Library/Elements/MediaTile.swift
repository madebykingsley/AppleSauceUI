import SwiftUI

struct MediaTilePresentation: Equatable {
    enum Hierarchy: Equatable {
        case standard
        case ranked(Int)
        case library
    }

    let title: String
    var secondaryText: String?
    var tertiaryText: String?
    var badge: String?
    var badgeAccessibilityLabel: String?
    var hierarchy = Hierarchy.standard

    var accessibilityLabel: String {
        var parts: [String] = []
        if case .ranked(let rank) = hierarchy {
            parts.append("Rank \(rank)")
        }
        parts.append(title)
        if let secondaryText { parts.append(secondaryText) }
        if let tertiaryText { parts.append(tertiaryText) }
        if let badgeAccessibilityLabel { parts.append(badgeAccessibilityLabel) }
        return parts.joined(separator: ", ")
    }
}

/// Standard artwork-and-metadata presentation used by albums, shows, libraries, and rankings.
struct MediaTile<Artwork: View>: View {
    let presentation: MediaTilePresentation
    var artworkLayout = ArtworkLayout.square
    @ViewBuilder let artwork: Artwork

    var body: some View {
        ArtworkTile(layout: artworkLayout) {
            artwork
        } metadata: {
            VStack(alignment: .leading, spacing: 1) {
                if case .ranked(let rank) = presentation.hierarchy {
                    Text(rank, format: .number)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 4) {
                    Text(presentation.title)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    if presentation.hierarchy == .library, let badge = presentation.badge {
                        MetadataBadge(label: badge)
                    }
                }

                if let secondaryText = presentation.secondaryText {
                    HStack(spacing: 4) {
                        Text(secondaryText).lineLimit(1)
                        if presentation.hierarchy != .library, let badge = presentation.badge {
                            MetadataBadge(label: badge)
                        }
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                if let tertiaryText = presentation.tertiaryText {
                    Text(tertiaryText)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .accessibilityHidden(true)
        }
        .accessibilityLabel(presentation.accessibilityLabel)
    }
}

#if DEBUG
#Preview("MediaTile — Variants") {
    HStack(alignment: .top) {
        MediaTile(presentation: .init(title: "Album", secondaryText: "Artist")) {
            ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient))
        }
        MediaTile(presentation: .init(title: "Show", secondaryText: "Publisher", badge: "E", badgeAccessibilityLabel: "Explicit", hierarchy: .ranked(2))) {
            ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient))
        }
    }
    .frame(width: 334)
    .padding()
    .tint(.purple)
}
#endif
