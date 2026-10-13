import SwiftUI

struct MusicHomeExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: MusicLayoutMetrics.sectionSpacing) {
                    MediaShelf(title: "Top Picks for You", items: MusicFixtures.topPicks, itemWidth: MusicLayoutMetrics.featureWidth, isHeaderActionable: false) { item in
                        PosterLockup(title: item.title, eyebrow: item.eyebrow, subtitle: item.subtitle, height: MusicLayoutMetrics.featureHeight, elevation: .prominent) {
                            Rectangle().fill(item.artwork.gradient)
                        }
                    }
                    MediaShelf(title: "Recently Played", items: MusicFixtures.recentlyPlayed, itemWidth: MusicLayoutMetrics.albumWidth, isHeaderActionable: true) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 38)
                        }
                    }
                    MediaShelf(title: "’90s", items: MusicFixtures.nineties, itemWidth: MusicLayoutMetrics.albumWidth) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 38)
                        }
                    }
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
                                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 38)
                            }
                        }
                    }
                    MediaShelf(title: "Playlists Made for You", items: MusicFixtures.playlists, itemWidth: MusicLayoutMetrics.featureWidth, isHeaderActionable: false) { item in
                        PosterLockup(title: item.title, eyebrow: item.eyebrow, subtitle: item.subtitle, height: MusicLayoutMetrics.featureHeight, elevation: .prominent) {
                            Rectangle().fill(item.artwork.gradient)
                        }
                    }
                    MediaShelf(title: "Stations for You", items: MusicFixtures.stations, itemWidth: MusicLayoutMetrics.albumWidth) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 35)
                        }
                    }
                    MediaShelf(title: "Find Your Mood", items: MusicFixtures.moods, itemWidth: MusicLayoutMetrics.albumWidth) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 35)
                        }
                    }
                    MediaShelf(title: "New Releases for You", items: MusicFixtures.newReleases, itemWidth: MusicLayoutMetrics.albumWidth, isHeaderActionable: true) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 38)
                        }
                    }
                    MediaShelf(title: "Concerts", items: MusicFixtures.concerts, itemWidth: MusicLayoutMetrics.albumWidth, scrollingPolicy: .continuous) { item in
                        SquareLockup(title: item.title, subtitle: item.venue, metadata: item.schedule, artworkAccessoryAccessibilityLabel: "\(item.month) \(item.day)") {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 36)
                        } artworkAccessory: {
                            CalendarDateBadge(month: item.month, day: item.day)
                        }
                    }
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
                    MediaShelf(title: "Replay: Your Top Music", items: MusicFixtures.replay, itemWidth: MusicLayoutMetrics.featureWidth, isHeaderActionable: false) { item in
                        PosterLockup(title: item.title, eyebrow: item.eyebrow, subtitle: item.subtitle, height: MusicLayoutMetrics.featureHeight, elevation: .prominent) {
                            Rectangle().fill(item.artwork.gradient)
                        }
                    }
                    Section {
                        VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                            SectionHeader(title: "Shared with You")
                                .padding(.horizontal, MusicLayoutMetrics.contentMargin)

                            HorizontalLockup(artworkSize: 102, spacing: 12) {
                                ArtworkPlaceholder(symbol: "mountain.2.fill", background: AnyShapeStyle(ArtworkPalette.ocean.gradient), cornerRadius: 5)
                                    .accessibilityHidden(true)
                            } content: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Existence Is Everything")
                                        .font(.subheadline)
                                        .lineLimit(2)
                                    Text("Album · Hawk Thief")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    Text("From Patrick")
                                        .font(.caption2.weight(.semibold))
                                        .padding(.horizontal, 7)
                                        .padding(.vertical, 3)
                                        .background(.quaternary, in: Capsule())
                                }
                                .accessibilityElement(children: .combine)
                            }
                            .padding(.horizontal, MusicLayoutMetrics.contentMargin)
                        }
                    }
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
