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
    case styleProfiles

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .music: "Music"
        case .podcasts: "Podcasts"
        case .styleProfiles: "Style Profiles"
        }
    }

    var subtitle: LocalizedStringResource {
        switch self {
        case .music: "Browse music discovery, radio, and library patterns"
        case .podcasts: "Explore listening, discovery, and library patterns"
        case .styleProfiles: "Compare one pattern across three visual languages"
        }
    }

    var systemImage: String {
        switch self {
        case .music: "music.note"
        case .podcasts: "antenna.radiowaves.left.and.right"
        case .styleProfiles: "paintpalette"
        }
    }

    var tint: Color {
        switch self {
        case .music: .pink
        case .podcasts: .purple
        case .styleProfiles: .indigo
        }
    }
}

private struct ExampleAppCard: View {
    let example: ExampleApp

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            RoundedRectangle(cornerRadius: 18)
                .fill(example.tint.gradient)
                .aspectRatio(3, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay {
                    Image(systemName: example.systemImage)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .accessibilityHidden(true)
                }
            VStack(alignment: .leading, spacing: 2) {
                Text(example.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(example.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
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
        case .styleProfiles:
            StyleProfilesExample(onExit: exitAction)
        }
    }
}

#if DEBUG
#Preview("Examples") {
    ContentView()
}
#endif
