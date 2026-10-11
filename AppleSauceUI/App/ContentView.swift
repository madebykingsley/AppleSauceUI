import SwiftUI

// App shell for browsing AppleSauce examples.
struct ContentView: View {
    @State private var selectedExample: ExampleApp?

    var body: some View {
        NavigationStack {
            List(ExampleApp.allCases) { example in
                Button {
                    selectedExample = example
                } label: {
                    ExampleAppCard(example: example)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Examples")
            .fullScreenCover(item: $selectedExample) { example in
                ExampleAppDestination(example: example) {
                    selectedExample = nil
                }
            }
        }
    }
}

private enum ExampleApp: String, CaseIterable, Identifiable {
    case music
    case podcasts

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .music: "Music"
        case .podcasts: "Podcasts"
        }
    }

    var subtitle: LocalizedStringResource {
        switch self {
        case .music: "Browse music discovery, radio, and library patterns"
        case .podcasts: "Explore listening, discovery, and library patterns"
        }
    }

    var systemImage: String {
        switch self {
        case .music: "music.note"
        case .podcasts: "antenna.radiowaves.left.and.right"
        }
    }

    var tint: Color {
        switch self {
        case .music: .pink
        case .podcasts: .purple
        }
    }
}

private struct ExampleAppCard: View {
    let example: ExampleApp

    var body: some View {
        ArtworkTile(layout: .landscape(aspectRatio: 3)) {
            RoundedRectangle(cornerRadius: 18)
                .fill(example.tint.gradient)
                .overlay {
                    Image(systemName: example.systemImage)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .accessibilityHidden(true)
                }
        } metadata: {
            VStack(alignment: .leading, spacing: 2) {
                Text(example.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(example.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}

private struct ExampleAppDestination: View {
    let example: ExampleApp
    let exitAction: () -> Void

    var body: some View {
        switch example {
        case .music:
            MusicAppExample(onExit: exitAction)
        case .podcasts:
            PodcastsAppExample(onExit: exitAction)
        }
    }
}

#if DEBUG
#Preview("Examples") {
    ContentView()
}
#endif
