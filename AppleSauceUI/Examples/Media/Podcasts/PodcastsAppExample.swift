import SwiftUI

struct PodcastsAppExample: View {
    @State private var selection: PodcastsAppTab
    let onExit: () -> Void

    init(initialSelection: PodcastsAppTab = .home, onExit: @escaping () -> Void = {}) {
        _selection = State(initialValue: initialSelection)
        self.onExit = onExit
    }

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                PodcastsHomeExample(onExit: onExit)
            }
            Tab("New", systemImage: "square.grid.2x2.fill", value: .new) {
                PodcastsNewExample(onExit: onExit)
            }
            Tab("Library", systemImage: "square.stack.fill", value: .library) {
                PodcastsLibraryExample(onExit: onExit)
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Search is outside this reference reconstruction."))
            }
        }
        .tint(.purple)
    }
}

enum PodcastsAppTab: Hashable {
    case home
    case new
    case library
    case search
}

#if DEBUG
#Preview("Podcasts App") {
    PodcastsAppExample()
}
#endif
