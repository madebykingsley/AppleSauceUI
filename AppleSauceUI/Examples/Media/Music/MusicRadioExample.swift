import SwiftUI

struct MusicRadioExample: View {
    @Environment(\.interfaceDensity) private var density

    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: sectionSpacing) {
                    MediaGrid(
                        title: nil,
                        items: MusicFixtures.radioShortcuts,
                        columnCount: 3,
                        rowSpacing: density.metrics.itemSpacing
                    ) { station in
                        Button(action: {}) {
                            ElevatedTile {
                                Image(station.artworkName)
                                    .resizable()
                                    .scaledToFit()
                                    .accessibilityHidden(true)
                            }
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(station.name)
                    }

                    MediaShelf(
                        title: "On Air Now",
                        items: MusicFixtures.radioOnAir,
                        itemWidth: HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard),
                        isHeaderActionable: false
                    ) { item in
                        MediaCard(
                            elevation: .none,
                            background: LinearGradient(
                                colors: item.footerColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            contentInsets: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
                        ) {
                            VStack(spacing: 4) {
                                Spacer()
                                Image(item.artworkName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 160, maxHeight: 120)
                                    .accessibilityHidden(true)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 232)
                            .background(Color(uiColor: .secondarySystemBackground))
                        } metadata: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.stationName)
                                    .font(.callout.weight(.semibold))
                                Text(item.programName)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.85))
                            }
                        }
                        .frame(height: 316)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(item.stationName), \(item.programName), on air now")
                    }

                    ColumnMediaShelf(
                        title: "Artists Take Over",
                        items: MusicFixtures.radioTakeovers,
                        rows: 3,
                        columnWidth: takeoverColumnWidth,
                        interItemSpacing: 10
                    ) { item in
                        HorizontalLockup(artworkSize: 88, spacing: 10) {
                            ArtworkImage(
                                assetName: item.artworkName,
                                placeholderSymbol: "music.microphone",
                                placeholderBackground: AnyShapeStyle(ArtworkPalette.monochrome.gradient),
                                placeholderSymbolPadding: 20
                            )
                            .accessibilityHidden(true)
                        } content: {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("RADIO TAKEOVER")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                Text(item.artist)
                                    .font(.callout.weight(.semibold))
                                    .lineLimit(1)
                                Text(item.summary)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            .accessibilityElement(children: .combine)
                        } accessory: {
                            Button("More actions for \(item.artist)", systemImage: "ellipsis", action: {})
                                .labelStyle(.iconOnly)
                                .tint(.secondary)
                        }
                    }

                    MediaShelf(
                        title: "Watch Interviews",
                        items: MusicFixtures.radioInterviews,
                        itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)
                    ) { item in
                        VideoLockup(title: item.title, subtitle: item.subtitle, artworkAspectRatio: 1.45) {
                            ArtworkImage(
                                assetName: item.resolvedArtworkName,
                                placeholderSymbol: item.symbol,
                                placeholderBackground: AnyShapeStyle(item.artwork.gradient),
                                placeholderSymbolPadding: 24
                            )
                        }
                    }

                    MediaShelf(
                        title: "Top Stations",
                        items: MusicFixtures.topRadioStations,
                        itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)
                    ) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 35)
                        }
                    }

                    MediaShelf(
                        title: "Stations by Genre",
                        items: MusicFixtures.radioGenreStations,
                        itemWidth: HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard)
                    ) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient), symbolPadding: 35)
                        }
                    }

                    Section {
                        VStack(alignment: .leading, spacing: density.metrics.itemSpacing) {
                            SectionHeader(title: "More to Explore")

                            VStack(spacing: density.metrics.itemSpacing) {
                                ForEach(MusicFixtures.radioExploreLinks) { link in
                                    NavigationLink {
                                        ContentUnavailableView(link.title, systemImage: "dot.radiowaves.left.and.right")
                                            .navigationTitle(Text(link.title))
                                    } label: {
                                        NavigationListItem(title: link.title, style: .capsule)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, density.metrics.contentMargin)
                    }
                }
                .padding(.top, density.metrics.contentMargin / 2)
                .padding(.bottom, density.metrics.contentMargin)
            }
            .visualComparisonScrollTracking()
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Radio")
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

    private let sectionSpacing: CGFloat = 30
    private let takeoverColumnWidth: CGFloat = 330
}

#if DEBUG
#Preview("Radio") {
    MusicRadioExample()
}

#Preview("Music Radio Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-music/radio",
            device: .iPhone,
            orientation: .portrait,
            colorScheme: .light,
            dynamicTypeSize: .large,
            notes: "Scrollable full-page reference including system and tab bars; mini player excluded from reconstruction."
        )
    ) {
        MusicAppExample(initialSelection: .radio)
    }
}
#endif
