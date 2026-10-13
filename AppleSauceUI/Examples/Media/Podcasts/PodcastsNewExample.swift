import SwiftUI

struct PodcastsNewExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: PodcastsLayoutMetrics.sectionSpacing) {
                    MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.newPromotions, itemWidth: PodcastsLayoutMetrics.promotionWidth) { item in
                        EditorialHero(eyebrow: LocalizedStringKey(item.eyebrow), title: LocalizedStringKey(item.title)) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.color.gradient))
                        }
                    }
                    RankedShelf(title: "Top Shows", items: PodcastsFixtures.newTopShows, itemWidth: PodcastsLayoutMetrics.showWidth) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    ColumnMediaShelf(title: "New Shows", items: PodcastsFixtures.newShows, rows: 2, columnWidth: PodcastsLayoutMetrics.showWidth, interItemSpacing: 16) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "Newly Added Video", items: PodcastsFixtures.newVideoShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    RankedShelf(title: "Top Series", items: PodcastsFixtures.newTopSeries, itemWidth: PodcastsLayoutMetrics.showWidth) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    ColumnMediaShelf(title: "Trending Episodes", items: PodcastsFixtures.trendingEpisodes, rows: 3, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
                        EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, progress: episode.progress, presentation: .featured, playAction: {}, overflowAction: {}) {
                            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                        }
                    } separator: {
                        Divider().padding(.leading, EpisodeRowPresentation.featured.separatorInset)
                    }
                    MediaShelf(title: "The Moment", subtitle: "Find out what's happening. Updated weekdays.", items: PodcastsFixtures.momentCards, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
                        PodcastEpisodeCard(episode: episode)
                    }
                    MediaShelf(title: "Latin American Heritage Month", items: PodcastsFixtures.newHeritageShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "Worth the Watch", items: PodcastsFixtures.worthWatchingCards, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
                        PodcastEpisodeCard(episode: episode)
                    }
                    RankedShelf(title: "Top True Crime Shows", items: PodcastsFixtures.newTrueCrimeShows, itemWidth: PodcastsLayoutMetrics.showWidth) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "New Trailers", items: PodcastsFixtures.trailers, itemWidth: PodcastsLayoutMetrics.trailerWidth) { trailer in
                        MediaCard(background: trailer.color.gradient) {
                            ArtworkPlaceholder(symbol: trailer.symbol, background: AnyShapeStyle(trailer.color.gradient))
                                .aspectRatio(PodcastsLayoutMetrics.trailerAspectRatio, contentMode: .fit)
                        } metadata: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(trailer.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                Text(trailer.description)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.78))
                                    .lineLimit(3)
                            }
                        } actions: {
                            HStack {
                                PlaybackButton(label: trailer.duration, accessibilityLabel: "Play trailer for \(trailer.title)", action: {})
                                    .tint(.white)
                                Spacer()
                                Button("Follow", systemImage: "plus", action: {})
                                    .labelStyle(.iconOnly)
                                    .accessibilityLabel("Follow \(trailer.title)")
                            }
                            .padding(.top, 3)
                        }
                    }
                    MediaShelf(title: "More to Discover", items: PodcastsFixtures.discovery, itemWidth: PodcastsLayoutMetrics.discoveryWidth, isHeaderActionable: false) { item in
                        Button(action: {}) {
                            ZStack {
                                Image(systemName: item.symbol)
                                    .font(.title)
                                    .opacity(0.28)
                                Text("(\(item.title))")
                                    .font(.headline)
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 112)
                            .background(item.color.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                    Section {
                        VStack(spacing: 0) {
                            ForEach(PodcastsFixtures.quickLinks) { link in
                                NavigationLink {
                                    ContentUnavailableView(link.title, systemImage: "mic")
                                        .navigationTitle(Text(link.title))
                                } label: {
                                    Text(link.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 12)
                                }
                                Divider()
                            }
                        }
                        .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)
                    } header: {
                        SectionHeader(title: "Podcasts Quick Links")
                            .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)
                    }
                }
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
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown, .orange.opacity(0.35))
                    }
                }
            }
        }
    }

}

#if DEBUG
#Preview("Podcasts New") {
    PodcastsNewExample()
        .frame(width: 402)
}

#Preview("Podcasts New — alternate width") {
    PodcastsNewExample()
        .frame(width: 480)
}

#Preview("Apple Podcasts New Comparison") {
    ReferenceComparison(spec: ReferenceSpec(id: "media/apple-podcasts/new", device: .iPhone, notes: "Full-page stitched reference; seam and repeated status bar are capture artifacts.")) {
        PodcastsAppExample(initialSelection: .new)
    }
}
#endif
