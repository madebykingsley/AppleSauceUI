import SwiftUI

struct MusicNewExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                sections
                    .padding(.top, density.metrics.contentMargin / 2)
                    .padding(.bottom, density.metrics.contentMargin)
            }
            .visualComparisonScrollTracking()
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("New")
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

    private let exploreLinks = [
        MusicLink(id: "concerts", title: "Concerts"),
        MusicLink(id: "spatial-audio", title: "Spatial Audio"),
        MusicLink(id: "music-videos", title: "Music Videos"),
        MusicLink(id: "charts", title: "Charts"),
        MusicLink(id: "genres", title: "Browse by Genre"),
        MusicLink(id: "decades", title: "Decades"),
        MusicLink(id: "moods", title: "Moods and Activities")
    ]

    private var sections: some View {
        LazyVStack(alignment: .leading, spacing: MusicLayoutMetrics.sectionSpacing) {
            MediaShelf(title: nil, subtitle: nil, items: MusicFixtures.newHeroItems, itemWidth: MusicLayoutMetrics.newFeatureWidth, alignment: .bottom) { item in
                EditorialHero(eyebrow: LocalizedStringKey(item.eyebrow), title: LocalizedStringKey(item.subtitle)) {
                    ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                }
            }
            ColumnMediaShelf(title: "Best New Songs", items: MusicFixtures.bestNewSongs, rows: 4, columnWidth: MusicLayoutMetrics.newFeatureWidth) { song in
                HorizontalLockup(title: song.title, subtitle: song.subtitle) {
                    ArtworkThumbnail(symbol: song.symbol, background: AnyShapeStyle(song.artwork.gradient), size: 48)
                } accessory: {
                    Button("More actions for \(song.title)", systemImage: "ellipsis", action: {})
                        .labelStyle(.iconOnly)
                }
                .padding(.trailing, 8)
                .padding(.vertical, 4)
            } separator: {
                Divider().padding(.leading, 60)
            }
            artworkShelf(title: "New This Week", items: MusicFixtures.newThisWeek)
            artworkShelf(title: "Recent Releases", items: MusicFixtures.recentReleases)
            videoShelf(title: "Watch Interviews", items: MusicFixtures.interviews)
            videoShelf(title: "New Music Videos", items: MusicFixtures.musicVideos)
            artworkShelf(title: "Coming Soon", items: MusicFixtures.comingSoon)
            Section {
                VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                    SectionHeader(title: "More to Explore")

                    VStack(spacing: density.metrics.itemSpacing) {
                        ForEach(exploreLinks) { link in
                            NavigationLink {
                                ContentUnavailableView(link.title, systemImage: "music.note")
                                    .navigationTitle(Text(link.title))
                            } label: {
                                HStack {
                                    Text(link.title)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .accessibilityHidden(true)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                        }
                    }
                }
                .padding(.horizontal, MusicLayoutMetrics.contentMargin)
            }
        }
    }

    private func artworkShelf(title: LocalizedStringKey, items: [MusicItem]) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.albumWidth) { item in
            SquareLockup(title: item.title, subtitle: item.subtitle) {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
            }
        }
    }

    private func videoShelf(title: LocalizedStringKey, items: [MusicItem]) -> some View {
        MediaShelf(title: title, items: items, itemWidth: MusicLayoutMetrics.albumWidth) { item in
            VStack(alignment: .leading, spacing: 6) {
                ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                    .aspectRatio(MusicLayoutMetrics.videoArtworkAspectRatio, contentMode: .fit)
                VStack(alignment: .leading, spacing: 1) {
                    Text(item.title).font(.footnote.weight(.medium)).foregroundStyle(.primary).lineLimit(1)
                    Text(item.subtitle).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                }
            }
            .accessibilityElement(children: .combine)
        }
    }
}

#if DEBUG
#Preview("New") {
    MusicNewExample()
}

#Preview("Apple Music New Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-music/new",
            device: .iPhone,
            orientation: .portrait,
            colorScheme: .light,
            dynamicTypeSize: .large,
            notes: "Scrollable full-page reference including system and tab bars."
        )
    ) {
        MusicAppExample(initialSelection: .new)
    }
}
#endif
