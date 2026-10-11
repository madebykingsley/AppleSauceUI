import SwiftUI

struct ColumnMediaShelf<Item: Identifiable, Row: View, Separator: View>: View {
    let title: LocalizedStringKey; var subtitle: LocalizedStringKey?; let items: [Item]; let rows: Int; let columnWidth: CGFloat
    var interItemSpacing: CGFloat = 0; var contentMargins: CGFloat = 20; var headerAction: () -> Void = {}
    @ViewBuilder let row: (Item) -> Row
    @ViewBuilder let separator: () -> Separator

    var body: some View {
        ShelfSection(title: title, subtitle: subtitle, isActionable: true, contentMargins: contentMargins, action: headerAction) {
            ColumnShelf(items: items, rows: rows, columnWidth: columnWidth, interItemSpacing: interItemSpacing, contentMargins: contentMargins, row: row, separator: separator)
        }
    }
}

extension ColumnMediaShelf where Separator == EmptyView {
    init(title: LocalizedStringKey, subtitle: LocalizedStringKey? = nil, items: [Item], rows: Int, columnWidth: CGFloat, interItemSpacing: CGFloat = 0, contentMargins: CGFloat = 20, headerAction: @escaping () -> Void = {}, @ViewBuilder row: @escaping (Item) -> Row) {
        self.init(title: title, subtitle: subtitle, items: items, rows: rows, columnWidth: columnWidth, interItemSpacing: interItemSpacing, contentMargins: contentMargins, headerAction: headerAction, row: row, separator: { EmptyView() })
    }
}

#if DEBUG
#Preview("ColumnMediaShelf — Variants") {
    ColumnMediaShelf(title: "Latest", items: LibraryPreviewItem.samples, rows: 2, columnWidth: 260) { item in HStack { Image(systemName: "waveform").frame(width: 44, height: 44).background(.quaternary); Text(item.title); Spacer() }.padding(.vertical, 4) }.frame(width: 402)
}
#endif
