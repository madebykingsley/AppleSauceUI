import SwiftUI

enum HorizontalShelfScrollingPolicy {
    case viewAligned
    case continuous
}

#if DEBUG
#Preview("HorizontalShelf — Variants") {
    VStack(spacing: 24) { HorizontalShelf(items: LibraryPreviewItem.samples, itemWidth: 130) { item in RoundedRectangle(cornerRadius: 8).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } }; HorizontalShelf(items: LibraryPreviewItem.samples.prefix(3), itemWidth: 180, scrollingPolicy: .continuous) { item in RoundedRectangle(cornerRadius: 8).fill(.quaternary).frame(height: 90).overlay { Text(item.title) } } }.frame(width: 402)
}
#endif

struct HorizontalShelf<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    let items: Items
    let itemWidth: CGFloat
    var alignment = VerticalAlignment.top
    var spacing: CGFloat = 12
    var contentMargins: CGFloat = 20
    var scrollingPolicy = HorizontalShelfScrollingPolicy.viewAligned
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        shelf
    }

    @ViewBuilder private var shelf: some View {
        let scrollView = ScrollView(.horizontal) {
            LazyHStack(alignment: alignment, spacing: spacing) {
                ForEach(items) { item in
                    itemView(item).frame(width: itemWidth)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, contentMargins, for: .scrollContent)
        .scrollIndicators(.hidden)
        if scrollingPolicy == .viewAligned {
            scrollView.scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        } else {
            scrollView
        }
    }
}
