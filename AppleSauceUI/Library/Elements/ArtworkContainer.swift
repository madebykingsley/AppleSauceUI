import SwiftUI

/// A bounded artwork viewport whose geometry is independent of the supplied artwork's source dimensions.
struct ArtworkContainer<ClipShape: Shape, Artwork: View, Decoration: View, Accessory: View>: View {
    let geometry: ArtworkContainerGeometry
    let clipShape: ClipShape
    let accessoryAlignment: Alignment
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let decoration: Decoration
    @ViewBuilder let accessory: Accessory

    init(
        geometry: ArtworkContainerGeometry,
        clipShape: ClipShape,
        accessoryAlignment: Alignment = .topTrailing,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder decoration: () -> Decoration,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.geometry = geometry
        self.clipShape = clipShape
        self.accessoryAlignment = accessoryAlignment
        self.artwork = artwork()
        self.decoration = decoration()
        self.accessory = accessory()
    }

    var body: some View {
        sizedViewport
            .clipShape(clipShape)
    }

    @ViewBuilder private var sizedViewport: some View {
        switch geometry {
        case .aspectRatio(let ratio):
            viewport
                .aspectRatio(ratio, contentMode: .fit)
                .frame(maxWidth: .infinity)
        case .size(let size):
            viewport
                .frame(width: size.width, height: size.height)
        case .height(let height):
            viewport
                .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        case .minimumHeight(let height):
            viewport
                .frame(maxWidth: .infinity, minHeight: height, maxHeight: .infinity)
        }
    }

    private var viewport: some View {
        Color.clear
            .overlay {
                artwork
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .overlay {
                decoration
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .overlay(alignment: accessoryAlignment) {
                accessory
            }
            .clipped()
    }
}

extension ArtworkContainer where Decoration == EmptyView, Accessory == EmptyView {
    init(
        geometry: ArtworkContainerGeometry,
        clipShape: ClipShape,
        @ViewBuilder artwork: () -> Artwork
    ) {
        self.init(
            geometry: geometry,
            clipShape: clipShape,
            artwork: { artwork() },
            decoration: { EmptyView() },
            accessory: { EmptyView() }
        )
    }
}

extension ArtworkContainer where Accessory == EmptyView {
    init(
        geometry: ArtworkContainerGeometry,
        clipShape: ClipShape,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder decoration: () -> Decoration
    ) {
        self.init(
            geometry: geometry,
            clipShape: clipShape,
            artwork: { artwork() },
            decoration: { decoration() },
            accessory: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("ArtworkContainer — Mixed Source Dimensions") {
    MediaShelf(
        title: "Artwork Geometry Regression",
        items: Array(LibraryPreviewItem.samples.prefix(3)),
        itemWidth: 161
    ) { item in
        let assetName = switch item.id {
        case 1: "MusicBlueHourArcade"
        case 2: "EpisodeCoastalTrail"
        default: "RegressionPortraitArtwork"
        }
        VideoLockup(title: item.title, artworkAspectRatio: 16 / 9) {
            ArtworkImage(
                assetName: assetName,
                placeholderSymbol: "photo",
                placeholderBackground: AnyShapeStyle(.gray.gradient)
            )
        }
    }
    .frame(width: 402)
}
#endif
