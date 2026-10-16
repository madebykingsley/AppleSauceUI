import SwiftUI

/// A compact category choice with a title and decorative symbol on a colored surface.
struct BrowseCategoryCard<Background: ShapeStyle>: View {
    enum Layout: Equatable, Sendable {
        case landscape
        case portrait

        var aspectRatio: CGFloat {
            switch self {
            case .landscape: 1.6
            case .portrait: 0.72
            }
        }
    }

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    let title: LocalizedStringResource
    let systemImage: String
    let background: Background
    let layout: Layout

    init(
        title: LocalizedStringResource,
        systemImage: String,
        background: Background,
        layout: Layout = .landscape
    ) {
        self.title = title
        self.systemImage = systemImage
        self.background = background
        self.layout = layout
    }

    var body: some View {
        VStack(alignment: .leading, spacing: density.metrics.metadataSpacing) {
            Text(title)
                .font(.body.weight(.semibold))
                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: density.metrics.metadataSpacing)

            Image(systemName: systemImage)
                .font(symbolFont)
                .symbolRenderingMode(styleProfile.imagery.symbolRenderingMode)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .accessibilityHidden(true)
        }
        .foregroundStyle(styleProfile.colors.onMedia)
        .padding(density.metrics.contentPadding)
        .frame(maxWidth: .infinity, minHeight: minimumHeight, alignment: .topLeading)
        .aspectRatio(dynamicTypeSize.isAccessibilitySize ? nil : layout.aspectRatio, contentMode: .fit)
        .background(background, in: cardShape)
        .overlay {
            cardShape.strokeBorder(
                styleProfile.effects.outlineColor,
                lineWidth: styleProfile.effects.outlineWidth
            )
        }
        .contentShape(cardShape)
        .accessibilityElement(children: .combine)
    }

    private var symbolFont: Font {
        switch layout {
        case .landscape: .title
        case .portrait: .largeTitle
        }
    }

    private var minimumHeight: CGFloat {
        switch layout {
        case .landscape: 96
        case .portrait: 160
        }
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
    }
}

#if DEBUG
#Preview("BrowseCategoryCard — Variants") {
    VStack(spacing: 24) {
        HStack {
            BrowseCategoryCard(
                title: "Alternative",
                systemImage: "guitars",
                background: Color.indigo.gradient
            )
            BrowseCategoryCard(
                title: "Science",
                systemImage: "atom",
                background: Color.teal.gradient
            )
        }

        MediaGrid(items: LibraryPreviewItem.samples, columnCount: 3) { _ in
            BrowseCategoryCard(
                title: "Television",
                systemImage: "play.tv.fill",
                background: Color.purple.gradient,
                layout: .portrait
            )
        }
    }
    .padding(.vertical)
}

#Preview("BrowseCategoryCard — Accessibility") {
    BrowseCategoryCard(
        title: "A Category With a Longer Localized Name",
        systemImage: "captions.bubble.fill",
        background: Color.blue.gradient
    )
    .padding()
    .environment(\.dynamicTypeSize, .accessibility3)
}
#endif
