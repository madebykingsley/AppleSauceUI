import SwiftUI

struct PodcastsSearchExample: View {
    @Environment(\.interfaceDensity) private var density
    @State private var searchText = ""
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                if searchText.isEmpty {
                    ScrollView {
                        MediaGrid(
                            items: PodcastsFixtures.searchCategories,
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
                prompt: "Shows, Episodes, and More"
            )
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AccountButton(action: onExit) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown, .orange.opacity(0.35))
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("Podcasts Search") {
    PodcastsSearchExample()
}

#Preview("Apple Podcasts Search Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-podcasts/search",
            device: .iPhone,
            notes: "Full-page reference includes system chrome, mini player, and tab bar."
        )
    ) {
        PodcastsAppExample(initialSelection: .search)
    }
}
#endif
