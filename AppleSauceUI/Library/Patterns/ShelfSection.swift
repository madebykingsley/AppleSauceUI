import SwiftUI

struct ShelfSection<Content: View>: View {
    let title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    var isActionable = false
    var prominence = SectionHeaderProminence.standard
    var spacing: CGFloat = 12
    var contentMargins: CGFloat = 20
    var action: () -> Void = {}
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            if isActionable { SectionHeaderButton(title: title, subtitle: subtitle, contentMargins: contentMargins, action: action) }
            else { SectionHeader(title: title, subtitle: subtitle, prominence: prominence).padding(.horizontal, contentMargins) }
            content
        }
    }
}

#if DEBUG
#Preview("ShelfSection — Variants") {
    VStack(spacing: 28) { ShelfSection(title: "Static Section") { Rectangle().fill(.quaternary).frame(height: 80) }; ShelfSection(title: "Actionable Section", subtitle: "Supporting detail", isActionable: true, action: {}) { Rectangle().fill(.quaternary).frame(height: 80) } }.frame(width: 402)
}
#endif
