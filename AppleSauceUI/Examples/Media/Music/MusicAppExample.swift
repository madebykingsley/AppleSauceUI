import SwiftUI

struct MusicAppExample: View {
    @State private var selection: MusicAppTab
    let onExit: () -> Void

    init(initialSelection: MusicAppTab = .home, onExit: @escaping () -> Void = {}) {
        _selection = State(initialValue: initialSelection)
        self.onExit = onExit
    }

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                MusicHomeExample(onExit: onExit)
            }

            Tab("New", systemImage: "square.grid.2x2.fill", value: .new) {
                MusicNewExample(onExit: onExit)
            }

            Tab("Radio", systemImage: "dot.radiowaves.left.and.right", value: .radio) {
                MusicRadioExample(onExit: onExit)
            }

            Tab("Library", systemImage: "music.note.square.stack.fill", value: .library) {
                MusicLibraryExample(onExit: onExit)
            }

            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .prominent) {
                MusicSearchExample(onExit: onExit)
            }
        }
        .tint(.pink)
    }
}

enum MusicAppTab: Hashable {
    case home
    case new
    case radio
    case library
    case search
}

#if DEBUG
#Preview("Music App") {
    MusicAppExample()
}
#endif
