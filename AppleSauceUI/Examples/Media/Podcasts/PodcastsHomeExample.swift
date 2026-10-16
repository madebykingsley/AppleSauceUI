import SwiftUI

struct PodcastsHomeExample: View {
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: sectionSpacing) {
                    MediaShelf(title: "Up Next", items: PodcastsFixtures.upNextCards, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { episode in
                        EpisodeCard(
                            date: episode.episodeDate,
                            showTitle: episode.show,
                            episodeTitle: episode.title,
                            summary: episode.description,
                            duration: episode.duration,
                            mediaBadge: episode.badge?.compactText,
                            mediaBadgeAccessibilityLabel: episode.badge?.accessibilityName,
                            background: episode.color.gradient
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                        }
                    }

                    MediaShelf(title: "Now with Video", items: PodcastsFixtures.homeVideoShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Your Top Shows", items: PodcastsFixtures.homeTopShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "You Might Like", subtitle: "Based on your listening", items: PodcastsFixtures.homeRecommendedShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Popular Shows", items: PodcastsFixtures.homePopularShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    ColumnMediaShelf(title: "You May Have Missed", subtitle: "From Shows You Follow", items: PodcastsFixtures.homeMissedEpisodes, rows: 3, columnWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard)) { episode in
                        HorizontalLockup(
                            artworkSize: featuredEpisodeArtworkSize,
                            spacing: featuredEpisodeSpacing,
                            alignment: .top
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                                .overlay(styleProfile.imagery.overlay)
                                .shadow(
                                    color: styleProfile.effects.standardShadow.color,
                                    radius: styleProfile.effects.standardShadow.radius,
                                    x: styleProfile.effects.standardShadow.x,
                                    y: styleProfile.effects.standardShadow.y
                                )
                                .accessibilityHidden(true)
                        } content: {
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(episode.episodeDate)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Text(episode.title)
                                        .font(.body.weight(.semibold))
                                        .lineLimit(2)
                                }
                                .accessibilityElement(children: .combine)
                                PlaybackButton(label: episode.duration, accessibilityLabel: "Play \(episode.title), \(episode.duration)", action: {})
                            }
                        } accessory: {
                            Button("More options for \(episode.title)", systemImage: "ellipsis", action: {})
                                .labelStyle(.iconOnly)
                                .buttonStyle(.plain)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    } separator: {
                        Divider().padding(.leading, featuredEpisodeArtworkSize + featuredEpisodeSpacing)
                    }

                    VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                        SectionHeader(title: "Apple TV+", eyebrow: "Subscriber Edition", leading: {
                            Image(systemName: "appletv.fill")
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(.black, in: Circle())
                        })
                        .padding(.horizontal, density.metrics.contentMargin)

                        MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.homeRecommendedShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                    }

                    MediaShelf(title: "News", subtitle: "From Your Shows", items: PodcastsFixtures.newsCards, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { episode in
                        EpisodeCard(
                            date: episode.episodeDate,
                            showTitle: episode.show,
                            episodeTitle: episode.title,
                            summary: episode.description,
                            duration: episode.duration,
                            mediaBadge: episode.badge?.compactText,
                            mediaBadgeAccessibilityLabel: episode.badge?.accessibilityName,
                            background: episode.color.gradient
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                        }
                    }

                    MediaShelf(title: "Music Interviews", items: PodcastsFixtures.homeMusicInterviews, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                            .buttonStyle(.plain)
                    }

                    MediaShelf(title: "Narrated Articles", subtitle: "From Your Subscriptions", items: PodcastsFixtures.narratedArticleCards, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { episode in
                        EpisodeCard(
                            date: episode.episodeDate,
                            showTitle: episode.show,
                            episodeTitle: episode.title,
                            summary: episode.description,
                            duration: episode.duration,
                            mediaBadge: episode.badge?.compactText,
                            mediaBadgeAccessibilityLabel: episode.badge?.accessibilityName,
                            background: episode.color.gradient
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                        }
                    }

                    ColumnMediaShelf(title: "More to Discover", subtitle: "Based on your listening", items: PodcastsFixtures.homeDiscoverEpisodes, rows: 3, columnWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard)) { episode in
                        HorizontalLockup(
                            artworkSize: featuredEpisodeArtworkSize,
                            spacing: featuredEpisodeSpacing,
                            alignment: .top
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                                .overlay(styleProfile.imagery.overlay)
                                .shadow(
                                    color: styleProfile.effects.standardShadow.color,
                                    radius: styleProfile.effects.standardShadow.radius,
                                    x: styleProfile.effects.standardShadow.x,
                                    y: styleProfile.effects.standardShadow.y
                                )
                                .accessibilityHidden(true)
                        } content: {
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(episode.episodeDate)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Text(episode.title)
                                        .font(.body.weight(.semibold))
                                        .lineLimit(2)
                                }
                                .accessibilityElement(children: .combine)
                                PlaybackButton(label: episode.duration, accessibilityLabel: "Play \(episode.title), \(episode.duration)", action: {})
                            }
                        } accessory: {
                            Button("More options for \(episode.title)", systemImage: "ellipsis", action: {})
                                .labelStyle(.iconOnly)
                                .buttonStyle(.plain)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    } separator: {
                        Divider().padding(.leading, featuredEpisodeArtworkSize + featuredEpisodeSpacing)
                    }

                    VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                        Button(action: {}) {
                            SectionHeader(title: LocalizedStringKey(PodcastsFixtures.referenceSeed.title), eyebrow: "If You Like", leading: {
                                ArtworkImage(assetName: PodcastsFixtures.referenceSeed.resolvedArtworkName, placeholderSymbol: PodcastsFixtures.referenceSeed.symbol, placeholderBackground: AnyShapeStyle(PodcastsFixtures.referenceSeed.color.gradient), placeholderSymbolPadding: 10)
                                    .frame(width: 40, height: 40)
                            }, accessory: {
                                Image(systemName: "chevron.right")
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.secondary)
                            })
                        }
                        .buttonStyle(.plain)
                        .accessibilityHint("Opens the section")
                        .padding(.horizontal, density.metrics.contentMargin)

                        MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.referenceShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                            SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                                ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                            }
                        }
                    }

                    MediaShelf(title: "Channels to Try", items: PodcastsFixtures.channels, itemWidth: channelWidth, isHeaderActionable: false) { channel in
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

                    ColumnMediaShelf(title: "Recently Played", items: PodcastsFixtures.recentlyPlayedEpisodes, rows: 1, columnWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard)) { episode in
                        HorizontalLockup(
                            artworkSize: featuredEpisodeArtworkSize,
                            spacing: featuredEpisodeSpacing,
                            alignment: .top
                        ) {
                            ArtworkImage(assetName: episode.resolvedArtworkName, placeholderSymbol: episode.symbol, placeholderBackground: AnyShapeStyle(episode.color.gradient))
                                .overlay(styleProfile.imagery.overlay)
                                .shadow(
                                    color: styleProfile.effects.standardShadow.color,
                                    radius: styleProfile.effects.standardShadow.radius,
                                    x: styleProfile.effects.standardShadow.x,
                                    y: styleProfile.effects.standardShadow.y
                                )
                                .accessibilityHidden(true)
                        } content: {
                            VStack(alignment: .leading, spacing: 8) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(episode.episodeDate)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Text(episode.title)
                                        .font(.body.weight(.semibold))
                                        .lineLimit(1)
                                    Text(episode.show)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                                .accessibilityElement(children: .combine)
                                PlaybackButton(
                                    label: episode.duration,
                                    accessibilityLabel: "Play \(episode.title), \(episode.duration)",
                                    progress: episode.progress,
                                    action: {}
                                )
                            }
                        } accessory: {
                            Button("More options for \(episode.title)", systemImage: "ellipsis", action: {})
                                .labelStyle(.iconOnly)
                                .buttonStyle(.plain)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    } separator: {
                        Divider().padding(.leading, featuredEpisodeArtworkSize + featuredEpisodeSpacing)
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

    private let sectionSpacing: CGFloat = 32
    private let channelWidth: CGFloat = 280
    private let featuredEpisodeArtworkSize: CGFloat = 90
    private let featuredEpisodeSpacing: CGFloat = 11
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
