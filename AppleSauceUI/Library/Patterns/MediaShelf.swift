import SwiftUI

struct MediaShelf<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    let title: LocalizedStringKey; var subtitle: LocalizedStringKey?; let items: Items; let itemWidth: CGFloat
    var isHeaderActionable = true; var alignment = VerticalAlignment.top; var spacing: CGFloat = 12; var contentMargins: CGFloat = 20
    var scrollingPolicy = HorizontalShelfScrollingPolicy.viewAligned; var headerAction: () -> Void = {}
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        ShelfSection(title: title, subtitle: subtitle, isActionable: isHeaderActionable, spacing: spacing, contentMargins: contentMargins, action: headerAction) {
            HorizontalShelf(items: items, itemWidth: itemWidth, alignment: alignment, spacing: spacing, contentMargins: contentMargins, scrollingPolicy: scrollingPolicy, itemView: itemView)
        }
    }
}

#if DEBUG
#Preview("MediaShelf — Variants") {
    MediaShelf(title: "Recommended", subtitle: "Selected for you", items: LibraryPreviewItem.samples, itemWidth: 130) { item in RoundedRectangle(cornerRadius: 10).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } }.frame(width: 402)
}
#endif
