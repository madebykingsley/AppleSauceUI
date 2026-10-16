import SwiftUI

struct MusicSearchExample: View {
    @State private var searchText = ""
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                if searchText.isEmpty {
                    ScrollView {
                        MediaGrid(title: "Browse Categories", items: MusicFixtures.searchCategories) { category in
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
#Preview {
    MusicSearchExample()
}
#endif
