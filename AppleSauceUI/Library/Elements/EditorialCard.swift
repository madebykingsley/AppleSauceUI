import SwiftUI

struct EditorialCard<Background: ShapeStyle>: View {
    let mark: String
    let description: String
    let background: Background
    var height: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(mark).font(.largeTitle.weight(.light)).foregroundStyle(.tint)
            Spacer()
            Text(description).font(.footnote).foregroundStyle(.white)
        }
        .padding(18).frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .leading)
        .background(background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("EditorialCard — Variants") {
    EditorialCard(mark: "FIELD\nNOTES", description: "Artists discuss the ideas behind their latest work.", background: .black.gradient, height: 360).padding().frame(width: 402).tint(.orange)
}
#endif
