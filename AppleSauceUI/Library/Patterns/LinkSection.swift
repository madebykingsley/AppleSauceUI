import SwiftUI

struct LinkSection<Item: Identifiable>: View {
    enum Style {
        case cards
        case plain
    }

    let title: LocalizedStringKey
    let items: [Item]
    var contentMargins: CGFloat = 20
    var rowBackground = Color(uiColor: .tertiarySystemFill)
    var style = Style.cards
    let label: (Item) -> LocalizedStringResource
    let action: (Item) -> Void

    var body: some View {
        ShelfSection(title: title, contentMargins: contentMargins) {
            VStack(spacing: style == .cards ? 12 : 0) {
                ForEach(items) { item in
                    Button(action: { action(item) }) {
                        HStack {
                            Text(label(item)).foregroundStyle(.tint)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(.tint)
                        }
                        .padding(.leading, style == .cards ? 16 : 0)
                        .padding(.trailing, style == .cards ? contentMargins : 0)
                        .padding(.vertical, style == .cards ? 18 : 12)
                        .background(style == .cards ? rowBackground : .clear, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    if style == .plain { Divider() }
                }
            }
            .padding(.horizontal, contentMargins)
        }
    }
}

#if DEBUG
#Preview("LinkSection — Variants") {
    ScrollView { VStack(spacing: 28) { LinkSection(title: "Explore", items: LibraryPreviewItem.samples.prefix(2).map { $0 }, label: { LocalizedStringResource(stringLiteral: $0.title) }, action: { _ in }); LinkSection(title: "More", items: LibraryPreviewItem.samples.suffix(2).map { $0 }, style: .plain, label: { LocalizedStringResource(stringLiteral: $0.title) }, action: { _ in }) } }.frame(width: 402)
}
#endif
