import SwiftUI

struct MusicLibraryExample: View {
    var onExit: () -> Void = {}

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ScreenTitle(title: "Library") {
                    HStack(spacing: 12) {
                        HStack(spacing: 20) {
                            Button("Add or sort library items", systemImage: "text.badge.plus", action: {}).labelStyle(.iconOnly)
                            Button("More library options", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
                        }
                        .font(.title3)
                        .frame(width: 102, height: 44)
                        .background(.thinMaterial, in: Capsule())
                        .buttonStyle(.plain)
                        AccountButton(action: onExit) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .foregroundStyle(.gray, .black)
                                .background(.black, in: Circle())
                        }
                    }
                }
                CategoryList(items: MusicFixtures.libraryCategories, action: { _ in }) { category in
                    CategoryRowLabel(icon: {
                        Image(systemName: category.symbol).font(.title3).foregroundStyle(.tint)
                    }, title: category.title)
                }
                .padding(.top, 12)
                .padding(.horizontal, MusicLayoutMetrics.contentMargin)
                MediaGrid(title: "Recently Added", items: MusicFixtures.recentlyAdded) { item in
                    SquareLockup(title: item.title, subtitle: item.subtitle) {
                        ArtworkPlaceholder(symbol: item.symbol, background: AnyShapeStyle(item.artwork.gradient))
                    }
                }
                .padding(.top, 24)
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
