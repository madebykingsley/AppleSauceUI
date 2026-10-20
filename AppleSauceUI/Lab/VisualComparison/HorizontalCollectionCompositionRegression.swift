import SwiftUI

#if DEBUG
struct HorizontalCollectionCompositionRegression: View {
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
                MediaShelf(
                    title: "Long-form features",
                    subtitle: "Mixed source artwork and variable supporting copy",
                    items: Array(LibraryPreviewItem.samples.prefix(3)),
                    itemWidth: width >= 500 ? 500 : 249
                ) { item in
                    EpisodeCard(
                        date: "New today",
                        episodeTitle: item.id == 1
                            ? "A concise feature title"
                            : "A substantially longer feature title that occupies several lines without escaping its reported card bounds",
                        summary: item.id == 3
                            ? "Supporting copy remains inside the card, leaving the following section to begin after the tallest collection item."
                            : "A shorter supporting caption.",
                        duration: "42 min",
                        mediaBadge: item.id == 2 ? "Video" : nil,
                        background: Color.indigo.gradient
                    ) {
                        ArtworkImage(
                            assetName: assetName(for: item.id),
                            placeholderSymbol: "photo",
                            placeholderBackground: AnyShapeStyle(.indigo.gradient)
                        )
                    }
                }

                Text("Following collection section")
                    .font(.title3.bold())
                    .padding(.horizontal)
        }
        .padding(.vertical)
        .frame(width: width)
    }

    private func assetName(for id: Int) -> String {
        switch id {
        case 1: "MusicBlueHourArcade"
        case 2: "EpisodeCoastalTrail"
        default: "RegressionPortraitArtwork"
        }
    }
}

#Preview("Collection Composition — Narrow", traits: .sizeThatFitsLayout) {
    HorizontalCollectionCompositionRegression(width: 320)
}

#Preview("Collection Composition — Alternate Width", traits: .sizeThatFitsLayout) {
    HorizontalCollectionCompositionRegression(width: 600)
        .dynamicTypeSize(.accessibility1)
}
#endif
