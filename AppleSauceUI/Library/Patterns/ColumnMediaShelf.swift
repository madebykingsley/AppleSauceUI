import SwiftUI

struct ShelfColumn<Element: Identifiable>: Identifiable {
    let elements: [Element]

    var id: Element.ID { elements[0].id }
}

enum ColumnShelfGrouping {
    static func columns<Element: Identifiable>(from elements: [Element], rows: Int) -> [ShelfColumn<Element>] {
        precondition(rows > 0, "Column shelves require at least one row")
        return stride(from: 0, to: elements.count, by: rows).map { start in
            ShelfColumn(elements: Array(elements[start..<min(start + rows, elements.count)]))
        }
    }
}

struct ColumnMediaShelf<Item: Identifiable, Row: View, Separator: View>: View {
    let title: LocalizedStringKey; var subtitle: LocalizedStringKey?; let items: [Item]; let rows: Int; let columnWidth: CGFloat
    var interItemSpacing: CGFloat = 0; var contentMargins: CGFloat = 20; var headerAction: () -> Void = {}
    @ViewBuilder let row: (Item) -> Row
    @ViewBuilder let separator: () -> Separator

    var body: some View {
        ShelfSection(title: title, subtitle: subtitle, isActionable: true, contentMargins: contentMargins, action: headerAction) {
            HorizontalShelfLayout(items: columns, itemWidth: columnWidth, spacing: 12, contentMargins: contentMargins) { column in
                VStack(spacing: interItemSpacing) {
                    ForEach(Array(column.elements.enumerated()), id: \.element.id) { index, item in
                        row(item)
                        if index < column.elements.count - 1 {
                            separator()
                        }
                    }
                }
            }
        }
    }

    private var columns: [ShelfColumn<Item>] {
        ColumnShelfGrouping.columns(from: items, rows: rows)
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
