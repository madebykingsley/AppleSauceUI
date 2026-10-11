import SwiftUI

struct MediaShelf<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Identifiable {
    @Environment(\.interfaceDensity) private var density

    var title: LocalizedStringKey?; var subtitle: LocalizedStringKey?; let items: Items; let itemWidth: CGFloat
    var isHeaderActionable = true; var alignment = VerticalAlignment.top; var spacing: CGFloat?; var contentMargins: CGFloat?
    var scrollingPolicy = HorizontalShelfScrollingPolicy.viewAligned; var headerAction: () -> Void = {}
    @ViewBuilder let itemView: (Items.Element) -> ItemView

    var body: some View {
        let resolvedSpacing = spacing ?? density.metrics.itemSpacing
        let resolvedMargins = contentMargins ?? density.metrics.contentMargin

        if let title {
            Section {
                VStack(alignment: .leading, spacing: resolvedSpacing) {
                    if isHeaderActionable {
                        Button(action: headerAction) {
                            SectionHeader(title: title, subtitle: subtitle, accessory: {
                                Image(systemName: "chevron.right")
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.secondary)
                            })
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, resolvedMargins)
                        .accessibilityHint("Opens the section")
                    } else {
                        SectionHeader(title: title, subtitle: subtitle)
                            .padding(.horizontal, resolvedMargins)
                    }

                    HorizontalShelfLayout(items: items, itemWidth: itemWidth, alignment: alignment, spacing: resolvedSpacing, contentMargins: resolvedMargins, scrollingPolicy: scrollingPolicy, itemView: itemView)
                }
            }
        } else {
            HorizontalShelfLayout(items: items, itemWidth: itemWidth, alignment: alignment, spacing: resolvedSpacing, contentMargins: resolvedMargins, scrollingPolicy: scrollingPolicy, itemView: itemView)
        }
    }
}

#if DEBUG
#Preview("MediaShelf — Variants") {
    MediaShelf(title: "Recommended", subtitle: "Selected for you", items: LibraryPreviewItem.samples, itemWidth: 130) { item in RoundedRectangle(cornerRadius: 10).fill(.quaternary).aspectRatio(1, contentMode: .fit).overlay { Text(item.title) } }.frame(width: 402)
}
#endif
