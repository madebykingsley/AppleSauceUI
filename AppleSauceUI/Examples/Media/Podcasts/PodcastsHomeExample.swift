import SwiftUI

struct PodcastsHomeExample: View {
    var onExit: () -> Void = {}

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: PodcastsLayoutMetrics.sectionSpacing) {
                ScreenTitle(title: "Home") {
                    AccountButton(action: onExit) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown, .orange.opacity(0.35))
                    }
                }
                episodeCardShelf(title: "Up Next", items: PodcastsFixtures.upNextCards)
                showShelf(title: "Now with Video", items: PodcastsFixtures.homeVideoShows)
                showShelf(title: "Your Top Shows", items: PodcastsFixtures.homeTopShows)
                showShelf(title: "You Might Like", subtitle: "Based on your listening", items: PodcastsFixtures.homeRecommendedShows)
                showShelf(title: "Popular Shows", items: PodcastsFixtures.homePopularShows)
                episodeShelf(title: "You May Have Missed", subtitle: "From Shows You Follow", items: PodcastsFixtures.homeMissedEpisodes)
                subscriberShelf
                episodeCardShelf(title: "News", subtitle: "From Your Shows", items: PodcastsFixtures.newsCards)
                showShelf(title: "Music Interviews", items: PodcastsFixtures.homeMusicInterviews)
                episodeCardShelf(title: "Narrated Articles", subtitle: "From Your Subscriptions", items: PodcastsFixtures.narratedArticleCards)
                episodeShelf(title: "More to Discover", subtitle: "Based on your listening", items: PodcastsFixtures.homeDiscoverEpisodes)
                referenceShelf
                channelShelf
                episodeShelf(title: "Recently Played", items: PodcastsFixtures.recentlyPlayedEpisodes, rows: 1, presentation: .recentlyPlayed)
            }
            .padding(.top, 2)
            .padding(.bottom, 24)
        }
        .visualComparisonScrollTracking()
        .scrollIndicators(.hidden)
        .background(Color(uiColor: .systemBackground))
    }

    private func showShelf(title: LocalizedStringKey, subtitle: LocalizedStringKey? = nil, items: [PodcastShowFixture]) -> some View {
        MediaShelf(title: title, subtitle: subtitle, items: items, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
            Button(action: {}) {
                MediaTile(presentation: show.tilePresentation()) {
                    ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                }
            }
            .buttonStyle(.plain)
        }
    }

    private func episodeShelf(title: LocalizedStringKey, subtitle: LocalizedStringKey? = nil, items: [PodcastEpisodeFixture], rows: Int = 3, presentation: EpisodeRowPresentation = .compact) -> some View {
        ColumnMediaShelf(title: title, subtitle: subtitle, items: items, rows: rows, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
            EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, progress: episode.progress, presentation: presentation, playAction: {}, overflowAction: {}, skipForwardAction: {}) {
                ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
            }
        } separator: {
            Divider().padding(.leading, presentation.separatorInset)
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

    private var subscriberShelf: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Apple TV+", eyebrow: "Subscriber Edition", leading: {
                Image(systemName: "appletv.fill").foregroundStyle(.white).frame(width: 40, height: 40).background(.black, in: Circle())
            })
            .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)
            HorizontalShelf(items: PodcastsFixtures.homeRecommendedShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                MediaTile(presentation: show.tilePresentation()) {
                    ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                }
            }
        }
    }

    private var referenceShelf: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderButton(title: LocalizedStringKey(PodcastsFixtures.referenceSeed.title), eyebrow: "If You Like", contentMargins: 0, action: {}) {
                ArtworkPlaceholder(symbol: PodcastsFixtures.referenceSeed.symbol, background: AnyShapeStyle(PodcastsFixtures.referenceSeed.color.gradient), symbolPadding: 10)
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)
            HorizontalShelf(items: PodcastsFixtures.referenceShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                MediaTile(presentation: show.tilePresentation()) {
                    ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                }
            }
        }
    }

    private var channelShelf: some View {
        MediaShelf(title: "Channels to Try", items: PodcastsFixtures.channels, itemWidth: PodcastsLayoutMetrics.channelWidth, isHeaderActionable: false) { channel in
            PromotionalCard(title: channel.title, description: channel.description, symbol: channel.symbol, background: channel.color.gradient, action: {})
        }
    }
}

#if DEBUG
#Preview("Podcasts Home") {
    PodcastsHomeExample()
        .frame(width: 402)
}

#Preview("Podcasts Home — alternate width") {
    PodcastsHomeExample()
        .frame(width: 480)
}

#Preview("Apple Podcasts Home Comparison") {
    ReferenceComparison(spec: ReferenceSpec(id: "media/apple-podcasts/home", device: .iPhone, notes: "Full-page stitched reference; mini player excluded.")) {
        PodcastsAppExample(initialSelection: .home)
    }
}
#endif
