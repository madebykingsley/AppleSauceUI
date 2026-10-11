import SwiftUI

/// A media shelf that supplies each stable item with its one-based display rank.
struct RankedShelf<Item: Identifiable, ItemView: View>: View {
    let title: LocalizedStringKey
    let items: [Item]
    let itemWidth: CGFloat
    var contentMargins: CGFloat = 20
    @ViewBuilder let itemView: (Int, Item) -> ItemView

    var body: some View {
        let rankedItems = items.enumerated().map { RankedShelfItem(rank: $0.offset + 1, item: $0.element) }
        MediaShelf(title: title, items: rankedItems, itemWidth: itemWidth, contentMargins: contentMargins) { rankedItem in
            itemView(rankedItem.rank, rankedItem.item)
        }
    }
}

private struct RankedShelfItem<Item: Identifiable>: Identifiable {
    let rank: Int
    let item: Item

    var id: Item.ID { item.id }
}
