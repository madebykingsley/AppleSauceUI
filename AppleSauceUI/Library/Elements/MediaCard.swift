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
    let background: Background
    let contentInsets: EdgeInsets?
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let metadata: Metadata
    @ViewBuilder let actions: Actions

    init(
        layout: MediaCardLayout = .standard,
        background: Background,
        contentInsets: EdgeInsets? = nil,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata,
        @ViewBuilder actions: () -> Actions
    ) {
        self.layout = layout
        self.background = background
        self.contentInsets = contentInsets
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = actions()
    }

    var body: some View {
        cardContent
            .foregroundStyle(styleProfile.colors.onMedia)
            .background(background)
            .clipShape(cardShape)
            .overlay { cardShape.stroke(styleProfile.effects.outlineColor, lineWidth: styleProfile.effects.outlineWidth) }
            .shadow(
                color: styleProfile.effects.standardShadow.color,
                radius: styleProfile.effects.standardShadow.radius,
                x: styleProfile.effects.standardShadow.x,
                y: styleProfile.effects.standardShadow.y
            )
            .accessibilityElement(children: .contain)
    }

    @ViewBuilder private var cardContent: some View {
        switch layout {
        case .standard:
            VStack(alignment: .leading, spacing: 0) {
                artwork
                cardDetails
                    .padding(resolvedContentInsets)
            }
        case .overlay:
            ZStack(alignment: .bottomLeading) {
                artwork
                    .overlay(styleProfile.imagery.scrim)
                cardDetails
                    .padding(resolvedContentInsets)
            }
        }
    }

    private var cardDetails: some View {
        VStack(alignment: .leading, spacing: 0) {
            metadata
            actions
        }
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
        background: Background,
        contentInsets: EdgeInsets? = nil,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.layout = layout
        self.background = background
        self.contentInsets = contentInsets
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = EmptyView()
    }
}

extension MediaCard where Background == StyleProfileSurface, Metadata == MediaCardMetadata, Actions == EmptyView {
    init(
        layout: MediaCardLayout = .standard,
        eyebrow: String? = nil,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        badge: String? = nil,
        badgeAccessibilityLabel: String? = nil,
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.layout = layout
        self.background = StyleProfileSurface()
        self.contentInsets = nil
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
            title: "A Walk Through the City",
            subtitle: "Daily Stories",
            metadata: "Today · 24 min",
            badge: "FEATURED"
        ) {
            ArtworkPlaceholder(symbol: "building.2.fill", background: AnyShapeStyle(.indigo.gradient))
                .aspectRatio(1.6, contentMode: .fit)
        }

        MediaCard(
            layout: .overlay,
            eyebrow: "Editors’ Choice",
            title: "A Walk Through the City",
            subtitle: "A reported story about how public spaces shape everyday life."
        ) {
            ArtworkPlaceholder(symbol: "building.2.fill", background: AnyShapeStyle(.teal.gradient))
                .aspectRatio(1.6, contentMode: .fit)
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
        ArtworkPlaceholder(symbol: "text.book.closed.fill", background: AnyShapeStyle(.blue.gradient))
            .aspectRatio(1.6, contentMode: .fit)
    }
    .padding()
    .frame(width: 402)
    .dynamicTypeSize(.accessibility3)
}
#endif
