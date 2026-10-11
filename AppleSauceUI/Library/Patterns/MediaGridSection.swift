import SwiftUI

struct MediaGridSection<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    let title: LocalizedStringKey; let items: Items; var contentMargins: CGFloat = 20
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        VStack(alignment: .leading, spacing: 12) { SectionHeader(title: title, prominence: .prominent); ArtworkGrid(items: items, itemView: itemView) }
            .padding(.horizontal, contentMargins)
    }
}

#if DEBUG
#Preview("MediaGridSection — Variants") {
    ScrollView { MediaGridSection(title: "Recently Added", items: LibraryPreviewItem.samples.prefix(3)) { item in RoundedRectangle(cornerRadius: 8).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } } }.frame(width: 402)
}
#endif
