import SwiftUI

struct PodcastsLibraryExample: View {
    var onExit: () -> Void = {}

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ScreenTitle(title: "Library") {
                    HStack(spacing: 12) {
                        Button("More library options", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
                        AccountButton(action: onExit) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.brown, .orange.opacity(0.35))
                        }
                    }
                }
                CategoryList(items: PodcastsFixtures.categories, action: { _ in }) { category in
                    CategoryRowLabel(icon: {
                        Image(systemName: category.symbol).font(.title3).foregroundStyle(.tint)
                    }, title: category.title)
                }
                .padding(.horizontal, PodcastsLayoutMetrics.contentMargin)
                MediaGridSection(title: "Recently Updated", items: PodcastsFixtures.libraryShows) { show in
                    Button(action: {}) {
                        MediaTile(presentation: show.tilePresentation(hierarchy: .library)) {
                            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 2)
            .padding(.bottom, 24)
        }
        .visualComparisonScrollTracking()
        .scrollIndicators(.hidden)
        .background(Color(uiColor: .systemBackground))
    }
}

#if DEBUG
#Preview("Podcasts Library") {
    PodcastsLibraryExample()
        .frame(width: 402)
}

#Preview("Podcasts Library — Accessibility") {
    PodcastsLibraryExample()
        .frame(width: 402)
        .dynamicTypeSize(.accessibility3)
}

#Preview("Apple Podcasts Library Comparison") {
    ReferenceComparison(spec: ReferenceSpec(id: "media/apple-podcasts/library", device: .iPhone, notes: "Full-page reference; mini player excluded.")) {
        PodcastsAppExample(initialSelection: .library)
    }
}
#endif
