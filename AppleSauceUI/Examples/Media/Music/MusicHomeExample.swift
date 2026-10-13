import SwiftUI

struct MusicHomeExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
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
                .padding(.top, density.metrics.contentMargin / 2)
                .padding(.bottom, density.metrics.contentMargin)
            }
            .visualComparisonScrollTracking()
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Home")
            .toolbarTitleDisplayMode(.inlineLarge)
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

    private func artworkShelf(title: LocalizedStringKey, items: [MusicItem], actionable: Bool = false, symbolPadding: CGFloat = 38) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.albumWidth, isHeaderActionable: actionable) { item in
            SquareLockup(title: item.title, subtitle: item.subtitle) {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: symbolPadding)
            }
        }
    }

    private func featuredShelf(title: LocalizedStringKey, items: [MusicItem]) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.featureWidth, isHeaderActionable: false) { item in
            PosterLockup(title: item.title, eyebrow: item.eyebrow, subtitle: item.subtitle, height: MusicLayoutMetrics.featureHeight, elevation: .prominent) {
                Rectangle().fill(item.artwork.gradient)
            }
        }
    }

    private var referenceShelf: some View {
        VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
            Button(action: {}) {
                SectionHeader(title: LocalizedStringKey(MusicFixtures.prisoner.title), eyebrow: "More Like", leading: {
                    ArtworkThumbnail(symbol: MusicFixtures.prisoner.symbol, background: AnyShapeStyle(MusicFixtures.prisoner.artwork.gradient))
                }, accessory: {
                    Image(systemName: "chevron.right")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.secondary)
                })
            }
            .buttonStyle(.plain)
            .accessibilityHint("Opens the section")
            .padding(.horizontal, MusicLayoutMetrics.contentMargin)
            MediaShelf(title: nil, subtitle: nil, items: MusicFixtures.moreLikePrisoner, itemWidth: MusicLayoutMetrics.albumWidth) { item in
                SquareLockup(title: item.title, subtitle: item.subtitle) {
                    ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                }
            }
        }
    }

    private var concertShelf: some View {
        MediaShelf(title: "Concerts", items: MusicFixtures.concerts, itemWidth: MusicLayoutMetrics.albumWidth, scrollingPolicy: .continuous) { item in
            SquareLockup(title: item.title, subtitle: item.venue, metadata: item.schedule, artworkAccessoryAccessibilityLabel: "\(item.month) \(item.day)") {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 36)
            } artworkAccessory: {
                CalendarDateBadge(month: item.month, day: item.day)
            }
        }
    }

    private var songsThatMatter: some View {
        Section {
            VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                SectionHeader(title: "The Songs That Matter")
                    .padding(.horizontal, MusicLayoutMetrics.contentMargin)

                VStack(alignment: .leading) {
                    Text("ALT\nCTRL")
                        .font(.largeTitle.weight(.light))
                        .foregroundStyle(.tint)
                    Spacer()
                    Text("CHVRCHES gives a nursery rhyme a powerful update with “Roses.”")
                        .font(.footnote)
                        .foregroundStyle(.white)
                }
                .padding(18)
                .frame(maxWidth: .infinity, minHeight: 443, maxHeight: 443, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [.gray.opacity(0.4), .brown.opacity(0.35), .black],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                )
                .accessibilityElement(children: .combine)
                .padding(.horizontal, MusicLayoutMetrics.contentMargin)
            }
        }
    }

    private var sharedWithYou: some View {
        Section {
            VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                SectionHeader(title: "Shared with You")
                    .padding(.horizontal, MusicLayoutMetrics.contentMargin)

                HorizontalLockup(title: "Existence Is Everything", subtitle: "Album · Hawk Thief", metadata: "From Patrick") {
                    ArtworkPlaceholder(symbol: "mountain.2.fill", background: AnyShapeStyle(ArtworkPalette.ocean.gradient), cornerRadius: 5)
                        .frame(width: 88, height: 88)
                }
                .padding(.horizontal, MusicLayoutMetrics.contentMargin)
            }
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
