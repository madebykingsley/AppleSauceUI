import SwiftUI
import Testing
@testable import AppleSauceUI

@MainActor
struct LayoutBoundsRegressionTests {
    @Test func featureCardReportsSpaceForAccessibilityTextAndActions() throws {
        let standard = try renderedSize(of: featureCard.dynamicTypeSize(.large))
        let accessibility = try renderedSize(of: featureCard.dynamicTypeSize(.accessibility3))

        #expect(standard.width == 249)
        #expect(accessibility.width == 249)
        #expect(accessibility.height > standard.height)
    }

    @Test func collectionCompositionIncludesFollowingSection() throws {
        let shelf = try renderedSize(of: collectionShelf.frame(width: 320))
        let composition = try renderedSize(
            of: VStack(spacing: 24) {
                collectionShelf
                Text("Following section")
                    .font(.headline)
            }
            .frame(width: 320)
        )

        #expect(composition.height > shelf.height + 24)
    }

    private var featureCard: some View {
        MediaCard(
            background: Color.indigo.gradient,
            artworkGeometry: .aspectRatio(1.6)
        ) {
            ArtworkImage(
                assetName: "EpisodeCoastalTrail",
                placeholderSymbol: "photo",
                placeholderBackground: AnyShapeStyle(.indigo.gradient)
            )
        } metadata: {
            VStack(alignment: .leading, spacing: 6) {
                Text("FEATURED CONVERSATION")
                    .font(.caption)
                Text("A long feature title that must participate in the card's reported layout bounds")
                    .font(.headline)
                Text("Supporting copy receives sufficient space rather than being painted outside a fixed or artwork-owned region.")
                    .font(.body)
            }
        } actions: {
            HStack {
                Button("Play episode", systemImage: "play.fill", action: {})
                Spacer()
                Button("More options", systemImage: "ellipsis", action: {})
                    .labelStyle(.iconOnly)
            }
            .padding(.top, 12)
        }
        .frame(width: 249)
    }

    private var collectionShelf: some View {
        MediaShelf(
            title: "Long-form features",
            items: LibraryPreviewItem.samples.prefix(2),
            itemWidth: 249
        ) { item in
            EpisodeCard(
                date: "New today",
                episodeTitle: "A long episode title that wraps without escaping the card bounds",
                summary: "Supporting copy remains inside the item so collection height follows the tallest content.",
                duration: "42 min",
                background: Color.indigo.gradient
            ) {
                ArtworkImage(
                    assetName: item.id == 1 ? "MusicBlueHourArcade" : "RegressionPortraitArtwork",
                    placeholderSymbol: "photo",
                    placeholderBackground: AnyShapeStyle(.indigo.gradient)
                )
            }
        }
        .dynamicTypeSize(.accessibility3)
    }

    private func renderedSize<Content: View>(of content: Content) throws -> CGSize {
        let renderer = ImageRenderer(content: content)
        renderer.scale = 1
        return try #require(renderer.uiImage).size
    }
}
