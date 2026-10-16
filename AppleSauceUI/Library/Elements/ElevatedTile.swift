import SwiftUI

/// A square elevated surface that frames supplied content and an optional footer.
struct ElevatedTile<Content: View, Footer: View>: View {
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let elevation: ElementElevation
    @ViewBuilder let content: Content
    @ViewBuilder let footer: Footer

    init(
        elevation: ElementElevation = .prominent,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.elevation = elevation
        self.content = content()
        self.footer = footer()
    }

    var body: some View {
        let shadow = styleProfile.effects.shadow(for: elevation)

        VStack(spacing: density.metrics.metadataSpacing) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            footer
        }
        .padding(density.metrics.contentPadding)
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .background(styleProfile.colors.surface, in: tileShape)
        .overlay {
            tileShape.strokeBorder(
                styleProfile.effects.outlineColor,
                lineWidth: styleProfile.effects.outlineWidth
            )
        }
        .shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
        .accessibilityElement(children: .combine)
    }

    private var tileShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: styleProfile.shapes.cardCornerRadius, style: .continuous)
    }
}

extension ElevatedTile where Footer == EmptyView {
    init(
        elevation: ElementElevation = .prominent,
        @ViewBuilder content: () -> Content
    ) {
        self.init(elevation: elevation, content: content, footer: { EmptyView() })
    }
}

#if DEBUG
#Preview("ElevatedTile — Destinations") {
    HStack {
        ElevatedTile {
            Image(systemName: "mountain.2.fill")
                .font(.largeTitle)
                .foregroundStyle(.green)
        } footer: {
            Text("Mountain Trails")
                .font(.caption)
                .lineLimit(1)
        }

        ElevatedTile(elevation: .standard) {
            Image(systemName: "building.2.fill")
                .font(.largeTitle)
                .foregroundStyle(.blue)
        } footer: {
            Text("City Guides")
                .font(.caption)
                .lineLimit(1)
        }
    }
    .padding()
    .frame(width: 360)
}
#endif
