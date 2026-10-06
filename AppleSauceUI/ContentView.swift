import SwiftUI

struct ContentView: View {
    @State private var selection: AppTab = .home

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: .home) {
                MusicHomeView()
            }

            Tab("New", systemImage: "square.grid.2x2", value: .new) {
                PlaceholderTab(title: "New", symbol: "sparkles")
            }

            Tab("Radio", systemImage: "dot.radiowaves.left.and.right", value: .radio) {
                PlaceholderTab(title: "Radio", symbol: "dot.radiowaves.left.and.right")
            }

            Tab("Library", systemImage: "music.note.square.stack.fill", value: .library) {
                PlaceholderTab(title: "Library", symbol: "music.note.list")
            }

            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .prominent) {
                SearchTab()
            }
        }
        .tabViewBottomAccessory {
            MiniPlayer()
        }
        .tint(.pink)
    }
}

private enum AppTab: Hashable {
    case home
    case new
    case radio
    case library
    case search
}

private enum LayoutMetrics {
    static let contentHorizontalPadding: CGFloat = 20
}

private struct MusicHomeView: View {
    private let recommendations = MusicItem.recommendations
    private let recentlyPlayed = MusicItem.recentlyPlayed
    private let stations = MusicItem.stations

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    FeatureSection(items: recommendations)
                    AlbumSection(title: "Recently Played", items: recentlyPlayed)
                    AlbumSection(title: "Stations for You", items: stations)
                    AlbumSection(title: "More Like Your Favorites", items: MusicItem.moreFavorites)
                }
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {}) {
                        ProfileImage()
                    }
                    .accessibilityLabel("Account")
                }
            }
        }
    }
}

private struct ProfileImage: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.purple.opacity(0.8), .pink, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Image(systemName: "person.fill")
                .foregroundStyle(.white)
        }
        .frame(width: 34, height: 34)
    }
}

private struct PlaceholderTab: View {
    let title: LocalizedStringKey
    let symbol: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView(title, systemImage: symbol)
                .navigationTitle(title)
        }
    }
}

private struct SearchTab: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ContentUnavailableView.search(text: searchText)
                .navigationTitle("Search")
                .searchable(text: $searchText, prompt: "Artists, Songs, Lyrics, and More")
        }
    }
}

private struct FeatureSection: View {
    let items: [MusicItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(title: "Top Picks for You")

            GeometryReader { proxy in
                let cardWidth = min(290, proxy.size.width * 0.76)

                ScrollView(.horizontal) {
                    LazyHStack(spacing: 14) {
                        ForEach(items) { item in
                            FeatureCard(item: item)
                                .frame(width: cardWidth, height: 390)
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, LayoutMetrics.contentHorizontalPadding, for: .scrollContent)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            }
            .frame(height: 390)
        }
    }
}

private struct FeatureCard: View {
    let item: MusicItem

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(item.artwork.gradient)

            Circle()
                .fill(.white.opacity(0.22))
                .frame(width: 230, height: 230)
                .blur(radius: 18)
                .offset(x: -80, y: -105)

            Circle()
                .fill(item.artwork.accent.opacity(0.55))
                .frame(width: 245, height: 245)
                .blur(radius: 32)
                .offset(x: 95, y: 100)

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    AppleMusicMark()
                }

                Spacer()

                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.7)
                    .lineLimit(2)

                Spacer()

                Text(item.eyebrow)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 4)

                Text(item.subtitle)
                    .font(.footnote)
                    .lineLimit(3)
                    .lineSpacing(2)
            }
            .foregroundStyle(.white)
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 14, y: 8)
        .accessibilityElement(children: .combine)
    }
}

private struct AlbumSection: View {
    let title: LocalizedStringKey
    let items: [MusicItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(title: title, showsChevron: true)

            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 14) {
                    ForEach(items) { item in
                        AlbumTile(item: item)
                            .frame(width: 154)
                    }
                }
            }
            .contentMargins(.horizontal, LayoutMetrics.contentHorizontalPadding, for: .scrollContent)
            .scrollIndicators(.hidden)
        }
    }
}

private struct AlbumTile: View {
    let item: MusicItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(item.artwork.gradient)

                Circle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 120, height: 120)
                    .blur(radius: 15)
                    .offset(x: -45, y: -45)

                VStack {
                    HStack {
                        Spacer()
                        AppleMusicMark(compact: true)
                    }
                    Spacer()
                    Image(systemName: item.symbol)
                        .font(.largeTitle)
                        .foregroundStyle(.white.opacity(0.92))
                    Spacer()
                }
                .padding(10)
            }
            .frame(height: 154)
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))

            Text(item.title)
                .font(.footnote)
                .fontWeight(.medium)
                .lineLimit(1)
                .padding(.top, 7)

            Text(item.subtitle)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct SectionTitle: View {
    let title: LocalizedStringKey
    var showsChevron = false

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 5) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)

                if showsChevron {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, LayoutMetrics.contentHorizontalPadding)
    }
}

private struct AppleMusicMark: View {
    var compact = false

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "apple.logo")
            Text("Music")
        }
        .font(compact ? .caption2 : .subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
    }
}

private struct MiniPlayer: View {
    var body: some View {
        HStack(spacing: 11) {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.black, .gray.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.white)
                }
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 1) {
                Text("iPhone → MacBook Air")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text("Man on the Moon")
                    .font(.body)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }

            Spacer(minLength: 4)

            Button(action: {}) {
                Image(systemName: "play.fill")
                    .font(.title3)
                    .frame(width: 38, height: 38)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Play")

            Button(action: {}) {
                Image(systemName: "forward.fill")
                    .font(.title3)
                    .frame(width: 36, height: 38)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Next")
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
    }
}

private struct MusicItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let eyebrow: String
    let symbol: String
    let artwork: ArtworkPalette

    static let recommendations = [
        MusicItem(id: "get-up", title: "Get Up!", subtitle: "Pearl Jam, Incubus, Foo Fighters, Soundgarden, and more", eyebrow: "Made for You", symbol: "figure.run", artwork: .sunset),
        MusicItem(id: "essentials", title: "Essentials", subtitle: "Songs that defined a generation of alternative music", eyebrow: "We Recommend", symbol: "music.mic", artwork: .midnight),
        MusicItem(id: "chill", title: "Chill Mix", subtitle: "A laid-back mix selected just for your afternoon", eyebrow: "Made for You", symbol: "cloud.sun.fill", artwork: .ocean)
    ]

    static let recentlyPlayed = [
        MusicItem(id: "reggae", title: "Reggae Essentials", subtitle: "Apple Music", eyebrow: "", symbol: "sun.max.fill", artwork: .forest),
        MusicItem(id: "rotation", title: "Heavy Rotation", subtitle: "Made for You", eyebrow: "", symbol: "repeat", artwork: .amber),
        MusicItem(id: "indie", title: "Indie Anthems", subtitle: "Apple Music", eyebrow: "", symbol: "guitars.fill", artwork: .rose),
        MusicItem(id: "late-night", title: "Late Night", subtitle: "Apple Music", eyebrow: "", symbol: "moon.stars.fill", artwork: .midnight)
    ]

    static let stations = [
        MusicItem(id: "discovery", title: "Discovery Station", subtitle: "Made for You", eyebrow: "", symbol: "sparkles", artwork: .violet),
        MusicItem(id: "rock", title: "Classic Rock Station", subtitle: "Apple Music", eyebrow: "", symbol: "bolt.fill", artwork: .sunset),
        MusicItem(id: "focus", title: "Focus Station", subtitle: "Apple Music", eyebrow: "", symbol: "waveform", artwork: .ocean)
    ]

    static let moreFavorites = [
        MusicItem(id: "acoustic", title: "Acoustic Favorites", subtitle: "Updated Friday", eyebrow: "", symbol: "guitars", artwork: .amber),
        MusicItem(id: "alternative", title: "Alternative", subtitle: "Apple Music", eyebrow: "", symbol: "star.fill", artwork: .rose),
        MusicItem(id: "deep-cuts", title: "Deep Cuts", subtitle: "Made for You", eyebrow: "", symbol: "record.circle", artwork: .forest)
    ]
}

private enum ArtworkPalette {
    case sunset
    case midnight
    case ocean
    case forest
    case amber
    case rose
    case violet

    var colors: [Color] {
        switch self {
        case .sunset: [.red, .orange, .yellow]
        case .midnight: [.black, .indigo, .gray]
        case .ocean: [.blue, .cyan, .mint]
        case .forest: [.green, .teal, .black]
        case .amber: [.orange, .yellow, .red]
        case .rose: [.pink, .red, .purple]
        case .violet: [.purple, .indigo, .blue]
        }
    }

    var accent: Color {
        colors.last ?? .white
    }

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    ContentView()
}
