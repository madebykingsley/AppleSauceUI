import SwiftUI

struct MusicSearchExample: View {
    @Environment(\.interfaceDensity) private var density
    @State private var searchText = ""
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                if searchText.isEmpty {
                    ScrollView {
                        MediaGrid(
                            items: MusicFixtures.searchCategories,
                            rowSpacing: density.metrics.itemSpacing
                        ) { category in
                            Button(action: {}) {
                                BrowseCategoryCard(
                                    title: category.title,
                                    systemImage: category.symbol,
                                    background: category.color.gradient
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical)
                    }
                    .visualComparisonScrollTracking()
                } else {
                    ContentUnavailableView.search(text: searchText)
                }
            }
            .navigationTitle("Search")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Artists, Songs, Lyrics, and More"
            )
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AccountButton(action: onExit) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundStyle(.gray, .black)
                            .background(.black, in: Circle())
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("Music Search") {
    MusicSearchExample()
}

#Preview("Apple Music Search Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-music/search",
            device: .iPhone,
            notes: "Full-page reference includes system chrome, mini player, and tab bar."
        )
    ) {
        MusicAppExample(initialSelection: .search)
    }
}
#endif
