import SwiftUI

struct PodcastsHomeExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: PodcastsLayoutMetrics.sectionSpacing) {
                    MediaShelf(title: "Up Next", items: PodcastsFixtures.upNextCards, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
                        PodcastEpisodeCard(episode: episode)
                    }

                    MediaShelf(title: "Now with Video", items: PodcastsFixtures.homeVideoShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Your Top Shows", items: PodcastsFixtures.homeTopShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "You Might Like", subtitle: "Based on your listening", items: PodcastsFixtures.homeRecommendedShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Popular Shows", items: PodcastsFixtures.homePopularShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    ColumnMediaShelf(title: "You May Have Missed", subtitle: "From Shows You Follow", items: PodcastsFixtures.homeMissedEpisodes, rows: 3, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
                        EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, progress: episode.progress, presentation: .compact, playAction: {}, overflowAction: {}) {
                            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                        }
                    } separator: {
                        Divider().padding(.leading, EpisodeRowPresentation.compact.separatorInset)
                    }

                    VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                        SectionHeader(title: "Apple TV+", eyebrow: "Subscriber Edition", leading: {
                            Image(systemName: "appletv.fill")
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(.black, in: Circle())
                        })
                        .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)

                        MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.homeRecommendedShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                    }

                    MediaShelf(title: "News", subtitle: "From Your Shows", items: PodcastsFixtures.newsCards, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
                        PodcastEpisodeCard(episode: episode)
                    }

                    MediaShelf(title: "Music Interviews", items: PodcastsFixtures.homeMusicInterviews, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Narrated Articles", subtitle: "From Your Subscriptions", items: PodcastsFixtures.narratedArticleCards, itemWidth: PodcastsLayoutMetrics.episodeCardWidth) { episode in
                        PodcastEpisodeCard(episode: episode)
                    }

                    ColumnMediaShelf(title: "More to Discover", subtitle: "Based on your listening", items: PodcastsFixtures.homeDiscoverEpisodes, rows: 3, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
                        EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, progress: episode.progress, presentation: .compact, playAction: {}, overflowAction: {}) {
                            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                        }
                    } separator: {
                        Divider().padding(.leading, EpisodeRowPresentation.compact.separatorInset)
                    }

                    VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                        Button(action: {}) {
                            SectionHeader(title: LocalizedStringKey(PodcastsFixtures.referenceSeed.title), eyebrow: "If You Like", leading: {
                                ArtworkPlaceholder(symbol: PodcastsFixtures.referenceSeed.symbol, background: AnyShapeStyle(PodcastsFixtures.referenceSeed.color.gradient), symbolPadding: 10)
                                    .frame(width: 40, height: 40)
                            }, accessory: {
                                Image(systemName: "chevron.right")
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.secondary)
                            })
                        }
                        .buttonStyle(.plain)
                        .accessibilityHint("Opens the section")
                        .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)

                        MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.referenceShows, itemWidth: PodcastsLayoutMetrics.showWidth) { show in
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                    }

                    MediaShelf(title: "Channels to Try", items: PodcastsFixtures.channels, itemWidth: PodcastsLayoutMetrics.channelWidth, isHeaderActionable: false) { channel in
                        Button(action: {}) {
                            VStack(alignment: .leading, spacing: 12) {
                                Image(systemName: channel.symbol)
                                    .font(.largeTitle)
                                Spacer()
                                Text(channel.title)
                                    .font(.headline)
                                Text(channel.description)
                                    .font(.caption)
                                    .lineLimit(3)
                            }
                            .foregroundStyle(.white)
                            .padding(16)
                            .frame(maxWidth: .infinity, minHeight: 190, alignment: .leading)
                            .background(channel.color.gradient, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }

                    ColumnMediaShelf(title: "Recently Played", items: PodcastsFixtures.recentlyPlayedEpisodes, rows: 1, columnWidth: PodcastsLayoutMetrics.episodeColumnWidth) { episode in
                        EpisodeRow(title: episode.title, show: episode.show, date: episode.episodeDate, duration: episode.duration, badge: episode.badge?.compactText, progress: episode.progress, presentation: .recentlyPlayed, playAction: {}, overflowAction: {}) {
                            ArtworkPlaceholder(symbol: episode.symbol, background: AnyShapeStyle(episode.color.gradient))
                        }
                    } separator: {
                        Divider().padding(.leading, EpisodeRowPresentation.recentlyPlayed.separatorInset)
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
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown, .orange.opacity(0.35))
                    }
                }
            }
        }
    }

}

#if DEBUG
#Preview("Podcasts Home") {
    PodcastsHomeExample()
}

#Preview("Apple Podcasts Home Comparison") {
    ReferenceComparison(spec: ReferenceSpec(id: "media/apple-podcasts/home", device: .iPhone, notes: "Full-page stitched reference; mini player excluded.")) {
        PodcastsAppExample(initialSelection: .home)
    }
}
#endif
