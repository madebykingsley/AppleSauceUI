import SwiftUI

struct CalendarDateBadge: View {
    let month: String; let day: Int; var width: CGFloat = 37; var height: CGFloat = 40
    private let badgeShape = RoundedRectangle(cornerRadius: 6, style: .continuous)

    var body: some View {
        VStack(spacing: -2) { Text(month).font(.caption2.weight(.medium)).foregroundStyle(.tint); Text(day, format: .number).font(.title3.weight(.semibold)).foregroundStyle(.primary) }
            .frame(width: width, height: height).background(.regularMaterial, in: badgeShape)
            .overlay { badgeShape.stroke(.secondary.opacity(0.35), lineWidth: 1) }.shadow(color: .black.opacity(0.12), radius: 1, y: 1)
            .accessibilityElement(children: .ignore).accessibilityLabel("\(month) \(day)")
    }
}

#if DEBUG
#Preview("CalendarDateBadge — Variants") { HStack { CalendarDateBadge(month: "OCT", day: 18); CalendarDateBadge(month: "NOV", day: 2, width: 44, height: 46) }.padding().tint(.orange) }
#endif
