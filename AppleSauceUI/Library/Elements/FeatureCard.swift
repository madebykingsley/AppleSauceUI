import SwiftUI

struct FeatureCard<Background: ShapeStyle>: View {
    let title: String
    let eyebrow: String?
    let subtitle: String
    let background: Background
    var height: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.largeTitle.weight(.semibold)).lineLimit(3).minimumScaleFactor(0.7).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                if let eyebrow, !eyebrow.isEmpty { Text(eyebrow).font(.footnote).foregroundStyle(.white.opacity(0.72)) }
                Text(subtitle).font(.footnote).lineLimit(3)
            }
        }
        .foregroundStyle(.white).padding(17)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .topLeading)
        .background(background, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("FeatureCard — Variants") {
    HStack { FeatureCard(title: "Featured Mix", eyebrow: "Made for You", subtitle: "A collection selected for today", background: .blue.gradient, height: 260); FeatureCard(title: "New Music", eyebrow: nil, subtitle: "Highlights from emerging artists", background: .purple.gradient, height: 260) }.padding().frame(width: 480)
}
#endif
