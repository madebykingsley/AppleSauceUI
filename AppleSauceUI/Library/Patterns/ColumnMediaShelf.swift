import SwiftUI

struct ColumnMediaShelf<Item: Identifiable, Row: View, Separator: View>: View {
    let title: LocalizedStringKey; var subtitle: LocalizedStringKey?; let items: [Item]; let rows: Int; let columnWidth: CGFloat
    var interItemSpacing: CGFloat = 0; var contentMargins: CGFloat = 20; var headerAction: () -> Void = {}
    @ViewBuilder let row: (Item) -> Row
    @ViewBuilder let separator: () -> Separator

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 12) {
                Button(action: headerAction) {
                    SectionHeader(title: title, subtitle: subtitle, accessory: {
                        Image(systemName: "chevron.right")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.secondary)
                    })
                }
                .buttonStyle(.plain)
                .padding(.horizontal, contentMargins)
                .accessibilityHint("Opens the section")

                ScrollView(.horizontal) {
                    LazyHGrid(rows: gridRows, spacing: 12) {
                        ForEach(items.enumerated(), id: \.element.id) { index, item in
                            row(item)
                                .frame(width: columnWidth)
                                .overlay(alignment: .bottom) {
                                    if index % resolvedRowCount < resolvedRowCount - 1, index < items.count - 1 {
                                        separator()
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, contentMargins, for: .scrollContent)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            }
        }
    }

    private var gridRows: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: interItemSpacing), count: resolvedRowCount)
    }

    private var resolvedRowCount: Int { max(rows, 1) }
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
