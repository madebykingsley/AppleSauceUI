import SwiftUI

struct DiscoveryCard<Background: ShapeStyle>: View {
    let title: String; let symbol: String; let background: Background; let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack { Image(systemName: symbol).font(.title).opacity(0.28); Text(title).font(.headline) }
                .foregroundStyle(.white).frame(maxWidth: .infinity, minHeight: 112)
                .background(background, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        }.buttonStyle(.plain)
    }
}

#if DEBUG
#Preview("DiscoveryCard — Variants") {
    VStack { DiscoveryCard(title: "Science", symbol: "atom", background: .blue.gradient, action: {}); DiscoveryCard(title: "Culture", symbol: "theatermasks.fill", background: .purple.gradient, action: {}) }.padding().frame(width: 320)
}
#endif
