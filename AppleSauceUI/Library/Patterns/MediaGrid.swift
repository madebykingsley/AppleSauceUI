import SwiftUI

/// A vertical media collection with optional section heading and shared margins.
struct MediaGrid<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    @Environment(\.interfaceDensity) private var density

    var title: LocalizedStringKey? = nil
    let items: Items
    var columnCount = 2
    var columnSpacing: CGFloat?
    var rowSpacing: CGFloat?
    var contentMargins: CGFloat?
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        VStack(alignment: .leading, spacing: density.metrics.sectionSpacing) {
            if let title {
                SectionHeader(title: title, prominence: .prominent)
            }
            LazyVGrid(columns: columns, alignment: .leading, spacing: rowSpacing ?? density.metrics.collectionRowSpacing) {
                ForEach(items) { item in
                    itemView(item)
                }
            }
        }
        .padding(.horizontal, contentMargins ?? density.metrics.contentMargin)
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: columnSpacing ?? density.metrics.itemSpacing), count: columnCount)
    }
}

#if DEBUG
#Preview("MediaGrid — Variants") {
    ScrollView {
        MediaGrid(title: "Explore Places", items: LibraryPreviewItem.samples, columnCount: 3) { item in
            ElevatedTile(elevation: .standard) {
                Image(systemName: "map.fill")
                    .font(.title2)
                    .foregroundStyle(.tint)
            } footer: {
                Text(item.title)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
    }
    .frame(width: 402)
}
#endif
