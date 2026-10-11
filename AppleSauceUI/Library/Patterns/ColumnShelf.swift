import SwiftUI

struct ShelfColumn<Element: Identifiable>: Identifiable {
    let elements: [Element]
    // A column follows its first item. Appends preserve existing column identity;
    // insertions or removals that regroup items intentionally change it.
    var id: Element.ID { elements[0].id }
}

#if DEBUG
#Preview("ColumnShelf — Variants") {
    ColumnShelf(items: LibraryPreviewItem.samples, rows: 2, columnWidth: 260) { item in HStack { Image(systemName: "music.note").frame(width: 44, height: 44).background(.quaternary); Text(item.title); Spacer() } } separator: { Divider().padding(.leading, 56) }.frame(width: 402)
}
#endif

enum ColumnShelfGrouping {
    static func columns<Element: Identifiable>(from elements: [Element], rows: Int) -> [ShelfColumn<Element>] {
        precondition(rows > 0, "Column shelves require at least one row")
        return stride(from: 0, to: elements.count, by: rows).map { start in
            ShelfColumn(elements: Array(elements[start..<min(start + rows, elements.count)]))
        }
    }
}

struct ColumnShelf<Item: Identifiable, Row: View, Separator: View>: View {
    let items: [Item]
    let rows: Int
    let columnWidth: CGFloat
    var columnSpacing: CGFloat = 12
    var interItemSpacing: CGFloat = 0
    var contentMargins: CGFloat = 20
    @ViewBuilder let row: (Item) -> Row
    @ViewBuilder let separator: () -> Separator

    var body: some View {
        HorizontalShelf(items: columns, itemWidth: columnWidth, spacing: columnSpacing, contentMargins: contentMargins) { column in
            VStack(spacing: interItemSpacing) {
                ForEach(Array(column.elements.enumerated()), id: \.element.id) { index, item in
                    row(item)
                    if index < column.elements.count - 1 { separator() }
                }
            }
        }
    }

    private var columns: [ShelfColumn<Item>] {
        ColumnShelfGrouping.columns(from: items, rows: rows)
    }
}

extension ColumnShelf where Separator == EmptyView {
    init(items: [Item], rows: Int, columnWidth: CGFloat, columnSpacing: CGFloat = 12, interItemSpacing: CGFloat = 0, contentMargins: CGFloat = 20, @ViewBuilder row: @escaping (Item) -> Row) {
        self.init(items: items, rows: rows, columnWidth: columnWidth, columnSpacing: columnSpacing, interItemSpacing: interItemSpacing, contentMargins: contentMargins, row: row, separator: { EmptyView() })
    }
}
