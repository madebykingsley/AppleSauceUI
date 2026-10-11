import SwiftUI

struct ScreenTitle<Actions: View>: View {
    let title: LocalizedStringKey
    var contentMargins: CGFloat = 20
    @ViewBuilder let actions: Actions

    init(
        title: LocalizedStringKey,
        contentMargins: CGFloat = 20,
        @ViewBuilder actions: () -> Actions
    ) {
        self.title = title
        self.contentMargins = contentMargins
        self.actions = actions()
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle.bold())
            Spacer()
            actions
        }
        .padding(.horizontal, contentMargins)
    }
}

#if DEBUG
#Preview("ScreenTitle — Variants") {
    VStack { ScreenTitle(title: "Library"); ScreenTitle(title: "Home") { Button("Account", systemImage: "person.crop.circle", action: {}).labelStyle(.iconOnly) } }.frame(width: 402)
}

#Preview("ScreenTitle — Accessibility") { ScreenTitle(title: "A Longer Screen Title") { Button("Account", systemImage: "person.crop.circle", action: {}).labelStyle(.iconOnly) }.dynamicTypeSize(.accessibility3).frame(width: 402) }
#endif

extension ScreenTitle where Actions == EmptyView {
    init(title: LocalizedStringKey, contentMargins: CGFloat = 20) {
        self.init(title: title, contentMargins: contentMargins) { EmptyView() }
    }
}
