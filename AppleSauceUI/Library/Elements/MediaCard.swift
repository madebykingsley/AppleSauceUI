import SwiftUI

/// Explicit structural layouts for landscape media-card content.
enum MediaCardLayout: String, CaseIterable, Identifiable {
    case standard
    case overlay

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .standard: "Standard"
        case .overlay: "Overlay"
        }
    }
}

/// A landscape media surface with artwork, semantic metadata, and optional independent actions.
struct MediaCard<Background: ShapeStyle, Artwork: View, Metadata: View, Actions: View>: View {
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let layout: MediaCardLayout
    let elevation: ElementElevation
    let background: Background
    let contentInsets: EdgeInsets?
    let artworkGeometry: ArtworkContainerGeometry
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let metadata: Metadata
    @ViewBuilder let actions: Actions

    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        background: Background,
        contentInsets: EdgeInsets? = nil,
        artworkGeometry: ArtworkContainerGeometry,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata,
        @ViewBuilder actions: () -> Actions
    ) {
        self.layout = layout
        self.elevation = elevation
        self.background = background
        self.contentInsets = contentInsets
        self.artworkGeometry = artworkGeometry
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = actions()
    }

    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        background: Background,
        contentInsets: EdgeInsets? = nil,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata,
        @ViewBuilder actions: () -> Actions
    ) {
        self.init(
            layout: layout,
            elevation: elevation,
            background: background,
            contentInsets: contentInsets,
            artworkGeometry: .aspectRatio(1.6),
            artwork: artwork,
            metadata: metadata,
            actions: actions
        )
    }

    var body: some View {
        let shadow = styleProfile.effects.shadow(for: elevation)

        cardContent
            .foregroundStyle(styleProfile.colors.onMedia)
            .background(background)
            .clipShape(cardShape)
            .overlay { cardShape.stroke(styleProfile.effects.outlineColor, lineWidth: styleProfile.effects.outlineWidth) }
            .shadow(
                color: shadow.color,
                radius: shadow.radius,
                x: shadow.x,
                y: shadow.y
            )
            .accessibilityElement(children: .contain)
    }

    @ViewBuilder private var cardContent: some View {
        switch layout {
        case .standard:
            VStack(alignment: .leading, spacing: 0) {
                artworkContainer
                cardDetails
                    .padding(resolvedContentInsets)
            }
        case .overlay:
            ZStack(alignment: .bottomLeading) {
                ArtworkContainer(
                    geometry: artworkGeometry,
                    clipShape: Rectangle()
                ) {
                    artwork
                } decoration: {
                    Rectangle().fill(styleProfile.imagery.treatment(.textLegibility))
                }
                cardDetails
                    .padding(resolvedContentInsets)
            }
        }
    }

    private var artworkContainer: some View {
        ArtworkContainer(
            geometry: artworkGeometry,
            clipShape: Rectangle()
        ) {
            artwork
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var cardDetails: some View {
        VStack(alignment: .leading, spacing: 0) {
            metadata
            actions
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.cardCornerRadius, style: .continuous)
    }

    private var resolvedContentInsets: EdgeInsets {
        contentInsets ?? EdgeInsets(
            top: density.metrics.contentPadding,
            leading: density.metrics.contentPadding,
            bottom: density.metrics.contentPadding,
            trailing: density.metrics.contentPadding
        )
    }
}

extension MediaCard where Actions == EmptyView {
    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        background: Background,
        contentInsets: EdgeInsets? = nil,
        artworkGeometry: ArtworkContainerGeometry,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.layout = layout
        self.elevation = elevation
        self.background = background
        self.contentInsets = contentInsets
        self.artworkGeometry = artworkGeometry
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = EmptyView()
    }

    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        background: Background,
        contentInsets: EdgeInsets? = nil,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.init(
            layout: layout,
            elevation: elevation,
            background: background,
            contentInsets: contentInsets,
            artworkGeometry: .aspectRatio(1.6),
            artwork: artwork,
            metadata: metadata
        )
    }
}

extension MediaCard where Background == StyleProfileSurface, Metadata == MediaCardMetadata, Actions == EmptyView {
    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        artworkGeometry: ArtworkContainerGeometry,
        eyebrow: String? = nil,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        badge: String? = nil,
        badgeAccessibilityLabel: String? = nil,
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.layout = layout
        self.elevation = elevation
        self.background = StyleProfileSurface()
        self.contentInsets = nil
        self.artworkGeometry = artworkGeometry
        self.artwork = artwork()
        self.metadata = MediaCardMetadata(
            layout: layout,
            eyebrow: eyebrow,
            title: title,
            subtitle: subtitle,
            metadata: metadata,
            badge: badge,
            badgeAccessibilityLabel: badgeAccessibilityLabel
        )
        self.actions = EmptyView()
    }

    init(
        layout: MediaCardLayout = .standard,
        elevation: ElementElevation = .standard,
        eyebrow: String? = nil,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        badge: String? = nil,
        badgeAccessibilityLabel: String? = nil,
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.init(
            layout: layout,
            elevation: elevation,
            artworkGeometry: .aspectRatio(1.6),
            eyebrow: eyebrow,
            title: title,
            subtitle: subtitle,
            metadata: metadata,
            badge: badge,
            badgeAccessibilityLabel: badgeAccessibilityLabel,
            artwork: artwork
        )
    }
}

struct StyleProfileSurface: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> AnyShapeStyle {
        environment.styleProfile.colors.surface
    }
}

#if DEBUG
#Preview("MediaCard — Variants") {
    VStack(spacing: 24) {
        MediaCard(
            title: "Blue Hour Arcade",
            subtitle: "North Arcade",
            metadata: "Today · 24 min",
            badge: "FEATURED"
        ) {
            ArtworkImage(assetName: "MusicBlueHourArcade", placeholderSymbol: "music.note", placeholderBackground: AnyShapeStyle(.indigo.gradient))
        }

        MediaCard(
            layout: .overlay,
            eyebrow: "Editors’ Choice",
            title: "Coastal Trail",
            subtitle: "A reported story about how public spaces shape everyday life."
        ) {
            ArtworkImage(assetName: "EpisodeCoastalTrail", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.teal.gradient))
        }
    }
    .padding()
    .frame(width: 402)
}

#Preview("MediaCard — Accessibility") {
    MediaCard(
        title: "A long media title that demonstrates how metadata grows at accessibility sizes",
        subtitle: "Supporting content remains readable without changing the card anatomy."
    ) {
        ArtworkImage(assetName: "EpisodeCoastalTrail", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.blue.gradient))
    }
    .padding()
    .frame(width: 402)
    .dynamicTypeSize(.accessibility3)
}
#endif
