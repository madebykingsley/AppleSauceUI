import SwiftUI

struct MusicSearchExample: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ContentUnavailableView.search(text: searchText)
                .navigationTitle("Search")
                .searchable(text: $searchText, prompt: "Artists, Songs, Lyrics, and More")
        }
    }
}

#if DEBUG
#Preview {
    MusicSearchExample()
}
#endif
