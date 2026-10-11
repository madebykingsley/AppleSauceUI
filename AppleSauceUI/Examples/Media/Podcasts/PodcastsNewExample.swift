import SwiftUI

struct PodcastsNewExample: View {
    var onExit: () -> Void = {}

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: PodcastsLayoutMetrics.sectionSpacing) {
                ScreenTitle(title: "New") {
                    AccountButton(action: onExit) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown, .orange.opacity(0.35))
                    }
                }
                MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.newPromotions, itemWidth: PodcastsLayoutMetrics.promotionWidth) { item in
                    EditorialHero(eyebrow: LocalizedStringKey(item.eyebrow), title: LocalizedStringKey(item.title)) {
                        ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.color.gradient))
                    }
                }
                showShelf(title: "Top Shows", items: PodcastsFixtures.newTopShows, ranked: true)
                ColumnMediaShelf(title: "New Shows", items: PodcastsFixtures.newShows, rows: 2, columnWidth: PodcastsLayoutMetrics.showWidth, interItemSpacing: 16) { show in
                    SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                        ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                    }
                }
                showShelf(title: "Newly Added Video", items: PodcastsFixtures.newVideoShows)
                showShelf(title: "Top Series", items: PodcastsFixtures.newTopSeries, ranked: true)
                episodeShelf(title: "Trending Episodes", items: PodcastsFixtures.trendingEpisodes)
                episodeCardShelf(title: "The Moment", subtitle: "Find out what's happening. Updated weekdays.", items: PodcastsFixtures.momentCards)
                showShelf(title: "Latin American Heritage Month", items: PodcastsFixtures.newHeritageShows)
                episodeCardShelf(title: "Worth the Watch", items: PodcastsFixtures.worthWatchingCards)
                showShelf(title: "Top True Crime Shows", items: PodcastsFixtures.newTrueCrimeShows, ranked: true)
                trailerShelf
                discoveryShelf
                LinkSection(title: "Podcasts Quick Links", items: PodcastsFixtures.quickLinks, style: .plain, label: { $0.title }, action: { _ in })
            }
            .padding(.top, 2)
            .padding(.bottom, 24)
        }
        .visualComparisonScrollTracking()
        .scrollIndicators(.hidden)
        .background(Color(uiColor: .systemBackground))
    }

    @ViewBuilder
    private func showShelf(title: LocalizedStringKey, items: [PodcastShowFixture], ranked: Bool = false) -> some View {
        if ranked {
            RankedShelf(title: title, items: items, itemWidth: PodcastsLayoutMetrics.showWidth) { rank, show in
                SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                    ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                }
            }
        } else {
            MediaShelf(title: title, items: items, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                    ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                }
            }
        }
    }

    private func episodeShelf(title: LocalizedStringKey, items: [PodcastEpisodeFixture]) -> some View {
        ColumnMediaShelf(title: title, items: items, rows: 3, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
            EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, presentation: .featured, playAction: {}, overflowAction: {}, skipForwardAction: {}) {
                ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
            }
        } separator: {
            Divider().padding(.leading, EpisodeRowPresentation.featured.separatorInset)
        }
    }

    private func episodeCardShelf(title: LocalizedStringKey, subtitle: LocalizedStringKey? = nil, items: [PodcastEpisodeCardFixture]) -> some View {
        MediaShelf(title: title, subtitle: subtitle, items: items, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
            EpisodeCard(show: episode.show, title: episode.title, date: episode.episodeDate, description: episode.description, duration: episode.duration, background: episode.color.gradient, playAction: {}, overflowAction: {}) {
                ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                    .overlay(alignment: .topTrailing) {
                        if let badge = episode.badge {
                            Label(badge.label, systemImage: "video.fill")
                                .font(.caption2.weight(.semibold))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .background(.ultraThinMaterial, in: Capsule())
                                .padding(8)
                                .accessibilityLabel(badge.label)
                        }
                    }
                    .aspectRatio(PodcastsLayoutMetrics.episodeCardAspectRatio, contentMode: .fit)
            }
        }
    }

    private var trailerShelf: some View {
        MediaShelf(title: "New Trailers", items: PodcastsFixtures.trailers, itemWidth: PodcastsLayoutMetrics.trailerWidth) { trailer in
            TrailerCard(title: trailer.title, description: trailer.description, duration: trailer.duration, background: trailer.color.gradient, playAction: {}, followAction: {}) {
                ArtworkPlaceholder(symbol: trailer.symbol, background: AnyShapeStyle(trailer.color.gradient))
                    .aspectRatio(PodcastsLayoutMetrics.trailerAspectRatio, contentMode: .fit)
            }
        }
    }

    private var discoveryShelf: some View {
        MediaShelf(title: "More to Discover", items: PodcastsFixtures.discovery, itemWidth: PodcastsLayoutMetrics.discoveryWidth, isHeaderActionable: false) { item in
            DiscoveryCard(title: "(\(item.title))", symbol: item.symbol, background: item.color.gradient, action: {})
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
