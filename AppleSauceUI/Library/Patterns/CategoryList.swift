import SwiftUI

struct CategoryList<Item: Identifiable, Label: View>: View {
    let items: [Item]
    var separatorInset: CGFloat = 40
    let action: (Item) -> Void
    @ViewBuilder let label: (Item) -> Label

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(items) { item in
                Button { action(item) } label: { label(item) }
                    .buttonStyle(.plain)
                Divider().padding(.leading, separatorInset)
            }
        }
    }
}

#if DEBUG
#Preview("CategoryList — Variants") {
    CategoryList(items: LibraryPreviewItem.samples.prefix(3).map { $0 }, action: { _ in }) { item in CategoryRowLabel(icon: { Image(systemName: "square.grid.2x2") }, title: LocalizedStringResource(stringLiteral: item.title)) }.padding().frame(width: 402)
}
#endif
