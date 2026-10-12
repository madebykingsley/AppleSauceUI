import SwiftUI

struct MusicLibraryExample: View {
    @Environment(\.interfaceDensity) private var density
    var onExit: () -> Void = {}

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(MusicFixtures.libraryCategories) { category in
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
                    MediaGrid(title: "Recently Added", items: MusicFixtures.recentlyAdded) { item in
                        SquareLockup(title: item.title, subtitle: item.subtitle) {
                            ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                        }
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
                ToolbarItemGroup {
                    Button("Add or sort library items", systemImage: "text.badge.plus", action: {})
                    Button("More library options", systemImage: "ellipsis", action: {})
                }

                ToolbarSpacer(.fixed)

                ToolbarItem {
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
}

#if DEBUG
#Preview("Library") {
    MusicLibraryExample()
}

#Preview("Apple Music Library Comparison") {
    ReferenceComparison(
        spec: ReferenceSpec(
            id: "media/apple-music/library",
            device: .iPhone,
            orientation: .portrait,
            colorScheme: .light,
            dynamicTypeSize: .large,
            notes: "Scrollable full-page reference including system and tab bars; mini player excluded from reconstruction."
        )
    ) {
        MusicAppExample(initialSelection: .library)
    }
}
#endif
