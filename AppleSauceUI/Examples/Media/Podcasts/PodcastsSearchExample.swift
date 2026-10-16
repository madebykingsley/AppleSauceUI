import SwiftUI

struct PodcastsSearchExample: View {
    @State private var searchText = ""
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                if searchText.isEmpty {
                    ScrollView {
                        MediaGrid(title: "Browse Categories", items: PodcastsFixtures.searchCategories) { category in
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
        .tint(.purple)
}
#endif
