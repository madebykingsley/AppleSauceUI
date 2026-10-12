import SwiftUI

struct PodcastsLibraryExample: View {
    @Environment(\.interfaceDensity) private var density
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(PodcastsFixtures.categories) { category in
                        NavigationLink {
                            ContentUnavailableView(category.title, systemImage: category.symbol)
                                .navigationTitle(Text(category.title))
                        } label: {
                            Label {
                                Text(category.title)
                                    .foregroundStyle(.primary)
                            } icon: {
                                Image(systemName: category.symbol)
                                    .foregroundStyle(.tint)
                            }
                            .imageScale(.large)
                        }
                    }
                }

                Section {
                    MediaGrid(title: "Recently Updated", items: PodcastsFixtures.libraryShows) { show in
                        Button(action: {}) {
                            SquareLockup(title: show.title, subtitle: show.updateInformation, badge: show.badge?.compactText, badgeAccessibilityLabel: show.badge?.accessibilityName, style: .library) {
                                ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listSectionSpacing(density.metrics.contentMargin * 2)
            .listStyle(.plain)
            .visualComparisonScrollTracking()
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Library")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("More library options", systemImage: "ellipsis", action: {})
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
