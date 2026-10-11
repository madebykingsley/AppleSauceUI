import SwiftUI

struct PromotionalCard<Background: ShapeStyle>: View {
    let title: String; let description: String; let symbol: String; let background: Background
    var minimumHeight: CGFloat = 190
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) { Image(systemName: symbol).font(.largeTitle); Spacer(); Text(title).font(.headline); Text(description).font(.caption).lineLimit(3) }
                .foregroundStyle(.white).padding(16).frame(maxWidth: .infinity, minHeight: minimumHeight, alignment: .leading)
                .background(background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }.buttonStyle(.plain)
    }
}

#if DEBUG
#Preview("PromotionalCard — Variants") {
    VStack { PromotionalCard(title: "Listen Together", description: "Stories selected for a shared afternoon.", symbol: "person.2.fill", background: .orange.gradient, action: {}); PromotionalCard(title: "Try Something New", description: "Discover a different perspective.", symbol: "sparkles", background: .pink.gradient, action: {}) }.padding().frame(width: 480)
}
#endif
