import SwiftUI

/// A vertical media collection with optional section heading and shared margins.
struct MediaGrid<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    var title: LocalizedStringKey?
    let items: Items
    var columnCount = 2
    var columnSpacing: CGFloat = 12
    var rowSpacing: CGFloat = 20
    var contentMargins: CGFloat = 20
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                SectionHeader(title: title, prominence: .prominent)
            }
            LazyVGrid(columns: columns, alignment: .leading, spacing: rowSpacing) {
                ForEach(items) { item in
                    itemView(item)
                }
            }
        }
        .padding(.horizontal, contentMargins)
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: columnSpacing), count: columnCount)
    }
}

#if DEBUG
#Preview("MediaGrid — Variants") {
    ScrollView {
        MediaGrid(title: "Recently Added", items: LibraryPreviewItem.samples) { item in
            RoundedRectangle(cornerRadius: 8).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) }
        }
    }
    .frame(width: 402)
}
#endif
