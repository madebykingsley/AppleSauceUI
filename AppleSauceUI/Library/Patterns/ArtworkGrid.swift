import SwiftUI

struct ArtworkGrid<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    let items: Items
    var columnCount = 2
    var columnSpacing: CGFloat = 12
    var rowSpacing: CGFloat = 20
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: rowSpacing) {
            ForEach(items) { item in itemView(item) }
        }
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: columnSpacing), count: columnCount)
    }
}

#if DEBUG
#Preview("ArtworkGrid — Variants") {
    ScrollView { ArtworkGrid(items: LibraryPreviewItem.samples) { item in RoundedRectangle(cornerRadius: 8).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } }.padding() }.frame(width: 402)
}

#Preview("ArtworkGrid — Alternate Width") { ArtworkGrid(items: LibraryPreviewItem.samples.prefix(4)) { item in RoundedRectangle(cornerRadius: 8).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } }.padding().frame(width: 480) }
#endif
