import SwiftUI

struct MusicHomeExample: View {
    var onExit: () -> Void = {}

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: MusicLayoutMetrics.headerSpacing) {
                ScreenTitle(title: "Home") {
                    AccountButton(action: onExit) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundStyle(.gray, .black)
                            .background(.black, in: Circle())
                    }
                }
                LazyVStack(alignment: .leading, spacing: MusicLayoutMetrics.sectionSpacing) {
                    featuredShelf(title: "Top Picks for You", items: MusicFixtures.topPicks)
                    artworkShelf(title: "Recently Played", items: MusicFixtures.recentlyPlayed, actionable: true)
                    artworkShelf(title: "’90s", items: MusicFixtures.nineties)
                    referenceShelf
                    featuredShelf(title: "Playlists Made for You", items: MusicFixtures.playlists)
                    artworkShelf(title: "Stations for You", items: MusicFixtures.stations, symbolPadding: 35)
                    artworkShelf(title: "Find Your Mood", items: MusicFixtures.moods, symbolPadding: 35)
                    artworkShelf(title: "New Releases for You", items: MusicFixtures.newReleases, actionable: true)
                    concertShelf
                    songsThatMatter
                    featuredShelf(title: "Replay: Your Top Music", items: MusicFixtures.replay)
                    sharedWithYou
                }
            }
            .padding(.top, 2)
            .padding(.bottom, 24)
        }
        .visualComparisonScrollTracking()
        .scrollIndicators(.hidden)
        .background(Color(uiColor: .systemBackground))
    }

    private func artworkShelf(title: LocalizedStringKey, items: [MusicItem], actionable: Bool = false, symbolPadding: CGFloat = 38) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.albumWidth, isHeaderActionable: actionable) { item in
            MediaTile(presentation: item.tilePresentation) {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: symbolPadding)
            }
        }
    }

    private func featuredShelf(title: LocalizedStringKey, items: [MusicItem]) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.featureWidth, isHeaderActionable: false) { item in
            FeatureCard(title: item.title, eyebrow: item.eyebrow, subtitle: item.subtitle, background: item.artwork.gradient, height: MusicLayoutMetrics.featureHeight)
        }
    }

    private var referenceShelf: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeaderButton(title: LocalizedStringKey(MusicFixtures.prisoner.title), eyebrow: "More Like", contentMargins: 0, action: {}) {
                ArtworkThumbnail(symbol: MusicFixtures.prisoner.symbol, background: AnyShapeStyle(MusicFixtures.prisoner.artwork.gradient))
            }
            .padding(.horizontal, MusicLayoutMetrics.contentMargin)
            HorizontalShelf(items: MusicFixtures.moreLikePrisoner, itemWidth: MusicLayoutMetrics.albumWidth) { item in
                MediaTile(presentation: item.tilePresentation) {
                    ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                }
            }
        }
    }

    private var concertShelf: some View {
        MediaShelf(title: "Concerts", items: MusicFixtures.concerts, itemWidth: MusicLayoutMetrics.albumWidth, scrollingPolicy: .continuous) { item in
            EventTile(title: item.title, venue: item.venue, schedule: item.schedule, month: item.month, day: item.day) {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 36)
            }
        }
    }

    private var songsThatMatter: some View {
        ShelfSection(title: "The Songs That Matter") {
            EditorialCard(mark: "ALT\nCTRL", description: "CHVRCHES gives a nursery rhyme a powerful update with “Roses.”", background: LinearGradient(colors: [.gray.opacity(0.4), .brown.opacity(0.35), .black], startPoint: .top, endPoint: .bottom), height: 443)
                .padding(.horizontal, MusicLayoutMetrics.contentMargin)
        }
    }

    private var sharedWithYou: some View {
        ShelfSection(title: "Shared with You") {
            MediaRow {
                ArtworkPlaceholder(symbol: "mountain.2.fill", background: AnyShapeStyle(ArtworkPalette.ocean.gradient), cornerRadius: 5)
                    .frame(width: 88, height: 88)
            } content: {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Existence Is Everything").font(.body.weight(.medium)).foregroundStyle(.primary)
                    Text("Album · Hawk Thief").font(.footnote).foregroundStyle(.secondary)
                    Label("From Patrick", systemImage: "message.fill").font(.caption).foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, MusicLayoutMetrics.contentMargin)
        }
    }
}

#if DEBUG
#Preview("Home") {
    MusicHomeExample()
}

#Preview("Apple Music Home Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-music/home",
            device: .iPhone,
            orientation: .portrait,
            colorScheme: .light,
            dynamicTypeSize: .large,
            notes: "Scrollable full-page reference including system and tab bars."
        )
    ) {
        MusicAppExample()
    }
}
#endif
