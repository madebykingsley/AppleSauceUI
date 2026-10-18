import SwiftUI

/// A compact horizontal episode presentation with independent playback and overflow controls.
struct EpisodeRow<Artwork: View>: View {
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let dateOrStatus: String?
    let title: String
    let supportingMetadata: String?
    let duration: String?
    let mediaBadge: String?
    let mediaBadgeAccessibilityLabel: String?
    let progress: Double?
    let artworkSize: CGFloat
    let artworkSpacing: CGFloat
    let artworkAlignment: VerticalAlignment
    let titleLineLimit: Int
    let playAction: (() -> Void)?
    let overflowAction: () -> Void
    @ViewBuilder let artwork: Artwork

    init(
        dateOrStatus: String? = nil,
        title: String,
        supportingMetadata: String? = nil,
        duration: String? = nil,
        mediaBadge: String? = nil,
        mediaBadgeAccessibilityLabel: String? = nil,
        progress: Double? = nil,
        artworkSize: CGFloat,
        artworkSpacing: CGFloat,
        artworkAlignment: VerticalAlignment = .top,
        titleLineLimit: Int = 2,
        playAction: (() -> Void)? = nil,
        overflowAction: @escaping () -> Void = {},
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.dateOrStatus = dateOrStatus
        self.title = title
        self.supportingMetadata = supportingMetadata
        self.duration = duration
        self.mediaBadge = mediaBadge
        self.mediaBadgeAccessibilityLabel = mediaBadgeAccessibilityLabel
        self.progress = progress
        self.artworkSize = artworkSize
        self.artworkSpacing = artworkSpacing
        self.artworkAlignment = artworkAlignment
        self.titleLineLimit = titleLineLimit
        self.playAction = playAction
        self.overflowAction = overflowAction
        self.artwork = artwork()
    }

    var body: some View {
        HorizontalLockup(
            artworkSize: artworkSize,
            spacing: artworkSpacing,
            alignment: artworkAlignment
        ) {
            artwork
                .overlay(styleProfile.imagery.overlay)
                .shadow(
                    color: styleProfile.effects.standardShadow.color,
                    radius: styleProfile.effects.standardShadow.radius,
                    x: styleProfile.effects.standardShadow.x,
                    y: styleProfile.effects.standardShadow.y
                )
                .accessibilityHidden(true)
        } content: {
            VStack(alignment: .leading, spacing: density.metrics.metadataSpacing) {
                VStack(alignment: .leading, spacing: density.metrics.metadataSpacing / 2) {
                    if let dateOrStatus, !dateOrStatus.isEmpty {
                        Text(dateOrStatus)
                            .font(styleProfile.typography.metadata)
                            .foregroundStyle(styleProfile.colors.secondaryText)
                    }

                    Text(title)
                        .font(styleProfile.typography.contentTitle)
                        .foregroundStyle(styleProfile.colors.primaryText)
                        .lineLimit(titleLineLimit)

                    inlineMetadata
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(verbatim: accessibilityMetadataLabel))

                if let duration, let playAction {
                    PlaybackButton(
                        label: duration,
                        accessibilityLabel: "Play \(title), \(duration)",
                        progress: progress,
                        action: playAction
                    )
                }
            }
        } accessory: {
            Button("More options for \(title)", systemImage: "ellipsis", action: overflowAction)
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .foregroundStyle(styleProfile.colors.secondaryText)
        }
        .padding(.vertical, density.metrics.metadataSpacing)
    }

    @ViewBuilder private var inlineMetadata: some View {
        if supportingMetadata != nil || (playAction == nil && duration != nil) || mediaBadge != nil {
            HStack(spacing: density.metrics.metadataSpacing) {
                if let supportingMetadata, !supportingMetadata.isEmpty {
                    Text(supportingMetadata)
                }
                if playAction == nil, let duration, !duration.isEmpty {
                    Text(duration)
                }
                if let mediaBadge, !mediaBadge.isEmpty {
                    MetadataBadge(label: mediaBadge)
                        .accessibilityLabel(mediaBadgeAccessibilityLabel ?? mediaBadge)
                }
            }
            .font(styleProfile.typography.metadata)
            .foregroundStyle(styleProfile.colors.secondaryText)
        }
    }

    var accessibilityMetadataLabel: String {
        [dateOrStatus, title, supportingMetadata, playAction == nil ? duration : nil, mediaBadgeAccessibilityLabel ?? mediaBadge]
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
#Preview("EpisodeRow — Variants") {
    VStack {
        EpisodeRow(
            dateOrStatus: "Today",
            title: "Listening for a Changing City",
            duration: "32 min",
            artworkSize: 90,
            artworkSpacing: 11,
            playAction: {}
        ) {
            ArtworkPlaceholder(symbol: "building.2.fill", background: AnyShapeStyle(Color.indigo.gradient))
        }

        EpisodeRow(
            title: "A compact episode for discovery",
            supportingMetadata: "Yesterday",
            duration: "18 min",
            mediaBadge: "Video",
            mediaBadgeAccessibilityLabel: "video episode",
            artworkSize: 63,
            artworkSpacing: 20,
            artworkAlignment: .center
        ) {
            ArtworkPlaceholder(symbol: "video.fill", background: AnyShapeStyle(Color.teal.gradient))
        }
    }
    .padding()
}
#endif
