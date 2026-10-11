import SwiftUI

enum SquareLockupStyle: Equatable {
    case standard
    case ranked(Int)
    case library
}

/// A square artwork presentation with a semantic metadata hierarchy.
struct SquareLockup<Artwork: View, ArtworkAccessory: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    let title: String
    var subtitle: String?
    var metadata: String?
    var badge: String?
    var badgeAccessibilityLabel: String?
    var artworkAccessoryAccessibilityLabel: String?
    var style = SquareLockupStyle.standard
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let artworkAccessory: ArtworkAccessory

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            artwork
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topLeading) { artworkAccessory.padding(8) }
            lockupMetadata
                .accessibilityHidden(true)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
    }

    private var lockupMetadata: some View {
        VStack(alignment: .leading, spacing: 1) {
            if case .ranked(let rank) = style {
                Text(rank, format: .number)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            HStack(spacing: 4) {
                Text(title)
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(.primary)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                if style == .library, let badge {
                    MetadataBadge(label: badge)
                }
            }
            if let subtitle {
                HStack(spacing: 4) {
                    Text(subtitle).lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                    if style != .library, let badge {
                        MetadataBadge(label: badge)
                    }
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
            if let metadata {
                Text(metadata)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
            }
        }
    }

    var accessibilityLabel: String {
        var parts: [String] = []
        if case .ranked(let rank) = style { parts.append("Rank \(rank)") }
        parts.append(title)
        if let subtitle { parts.append(subtitle) }
        if let metadata { parts.append(metadata) }
        if let badgeAccessibilityLabel { parts.append(badgeAccessibilityLabel) }
        if let artworkAccessoryAccessibilityLabel { parts.append(artworkAccessoryAccessibilityLabel) }
        return parts.joined(separator: ", ")
    }
}

extension SquareLockup where ArtworkAccessory == EmptyView {
    init(
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        badge: String? = nil,
        badgeAccessibilityLabel: String? = nil,
        style: SquareLockupStyle = .standard,
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.init(title: title, subtitle: subtitle, metadata: metadata, badge: badge, badgeAccessibilityLabel: badgeAccessibilityLabel, artworkAccessoryAccessibilityLabel: nil, style: style, artwork: artwork, artworkAccessory: { EmptyView() })
    }
}

#if DEBUG
#Preview("SquareLockup — Variants") {
    HStack(alignment: .top) {
        SquareLockup(title: "Album", subtitle: "Artist") {
            ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient))
        }
        SquareLockup(title: "Show", subtitle: "Publisher", badge: "E", badgeAccessibilityLabel: "Explicit", style: .ranked(2)) {
            ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient))
        }
    }
    .frame(width: 334)
    .padding()
}

#Preview("SquareLockup — Accessibility") {
    SquareLockup(title: "A Long Album Title That Wraps", subtitle: "A Long Artist Name", metadata: "Additional information") {
        ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient))
    }
    .frame(width: 220)
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
