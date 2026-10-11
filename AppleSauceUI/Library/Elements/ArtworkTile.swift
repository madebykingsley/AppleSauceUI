import SwiftUI

enum ArtworkLayout: Equatable {
    case square
    case landscape(aspectRatio: CGFloat)
}

#if DEBUG
#Preview("ArtworkTile — Variants") {
    HStack(alignment: .top) {
        ArtworkTile { Rectangle().fill(.blue.gradient) } metadata: { Text("Square artwork").font(.caption) }
        ArtworkTile(layout: .landscape(aspectRatio: 1.6)) { Rectangle().fill(.purple.gradient) } metadata: { Text("Landscape artwork").font(.caption) } badge: { Image(systemName: "star.fill").padding(4).background(.regularMaterial, in: Circle()) }
    }.padding().frame(width: 480)
}
#endif

struct ArtworkTile<Artwork: View, Metadata: View, Badge: View>: View {
    var layout = ArtworkLayout.square
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let metadata: Metadata
    @ViewBuilder let badge: Badge

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            artwork
                .aspectRatio(aspectRatio, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topTrailing) { badge.padding(6) }
            metadata
        }
        .accessibilityElement(children: .combine)
    }

    private var aspectRatio: CGFloat {
        switch layout {
        case .square: 1
        case .landscape(let aspectRatio): aspectRatio
        }
    }
}

extension ArtworkTile where Badge == EmptyView {
    init(
        layout: ArtworkLayout = .square,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.init(layout: layout, artwork: artwork, metadata: metadata) { EmptyView() }
    }
}
