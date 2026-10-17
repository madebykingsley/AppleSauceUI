import SwiftUI

struct PodcastsNewExample: View {
    @Environment(\.interfaceDensity) private var density
    @Environment(\.styleProfile) private var styleProfile

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: sectionSpacing) {
                    MediaShelf(title: nil, subtitle: nil, items: PodcastsFixtures.newPromotions, itemWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard)) { item in
                        EditorialHero(eyebrow: LocalizedStringKey(item.eyebrow), title: LocalizedStringKey(item.title)) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.color.gradient))
                        }
                    }
                    RankedShelf(title: "Top Shows", items: PodcastsFixtures.newTopShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    ColumnMediaShelf(title: "New Shows", items: PodcastsFixtures.newShows, rows: 2, columnWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard), interItemSpacing: 16) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "Newly Added Video", items: PodcastsFixtures.newVideoShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    RankedShelf(title: "Top Series", items: PodcastsFixtures.newTopSeries, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    ColumnMediaShelf(title: "Trending Episodes", items: PodcastsFixtures.trendingEpisodes, rows: 3, columnWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard)) { episode in
                        HorizontalLockup(
                            artworkSize: compactEpisodeArtworkSize,
                            spacing: compactEpisodeSpacing,
                            alignment: .center
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
                                    Text(episode.title)
                                        .font(.body.weight(.semibold))
                                        .lineLimit(2)
                                    HStack(spacing: 4) {
                                        Text(episode.episodeDate)
                                        Text("·")
                                        Text(episode.duration)
                                        if let badge = episode.badge?.compactText {
                                            MetadataBadge(label: badge)
                                        }
                                    }
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                }
                                .accessibilityElement(children: .combine)
                            }
                        } accessory: {
                            Button("More options for \(episode.title)", systemImage: "ellipsis", action: {})
                                .labelStyle(.iconOnly)
                                .buttonStyle(.plain)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    } separator: {
                        Divider().padding(.leading, compactEpisodeArtworkSize + compactEpisodeSpacing)
                    }
                    MediaShelf(title: "The Moment", subtitle: "Find out what's happening. Updated weekdays.", items: PodcastsFixtures.momentCards, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { episode in
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
                    MediaShelf(title: "Latin American Heritage Month", items: PodcastsFixtures.newHeritageShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { show in
                        SquareLockup(title: show.title, subtitle: show.category, metadata: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "Worth the Watch", items: PodcastsFixtures.worthWatchingCards, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { episode in
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
                    RankedShelf(title: "Top True Crime Shows", items: PodcastsFixtures.newTrueCrimeShows, itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)) { rank, show in
                        SquareLockup(title: show.title, subtitle: show.publisher, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .ranked(rank)) {
                            ArtworkImage(assetName: show.resolvedArtworkName, placeholderSymbol: show.symbol, placeholderBackground: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    MediaShelf(title: "New Trailers", items: PodcastsFixtures.trailers, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard)) { trailer in
                        MediaCard(background: trailer.color.gradient) {
                            ArtworkImage(assetName: trailer.resolvedArtworkName, placeholderSymbol: trailer.symbol, placeholderBackground: AnyShapeStyle(trailer.color.gradient))
                                .aspectRatio(trailerAspectRatio, contentMode: .fit)
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
                    MediaShelf(title: "More to Discover", items: PodcastsFixtures.discovery, itemWidth: HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard), isHeaderActionable: false) { item in
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
                                    NavigationListItem(title: link.title, style: .plain)
                                }
                            }
                        }
                        .padding(.horizontal, density.metrics.contentMargin)
                    } header: {
                        SectionHeader(title: "Podcasts Quick Links")
                            .padding(.horizontal, density.metrics.contentMargin)
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

    private let sectionSpacing: CGFloat = 32
    private let compactEpisodeArtworkSize: CGFloat = 63
    private let compactEpisodeSpacing: CGFloat = 20
    private let trailerAspectRatio: CGFloat = 1.45
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
