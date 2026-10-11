import SwiftUI

struct EventTile<Artwork: View>: View {
    let title: String
    let venue: String
    let schedule: String
    let month: String
    let day: Int
    @ViewBuilder let artwork: Artwork

    var body: some View {
        ArtworkTile {
            artwork.overlay(alignment: .topLeading) {
                CalendarDateBadge(month: month, day: day).padding(8)
            }
        } metadata: {
            VStack(alignment: .leading, spacing: 0) {
                Text(title).font(.footnote.weight(.medium)).foregroundStyle(.primary).lineLimit(1)
                Text(venue).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                Text(schedule).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
            }
        }
        .accessibilityLabel("\(title), \(venue), \(schedule), \(month) \(day)")
    }
}

#if DEBUG
#Preview("EventTile — Variants") {
    EventTile(title: "Live Performance", venue: "Civic Hall", schedule: "Friday at 8:00 PM", month: "OCT", day: 18) { ArtworkPlaceholder(symbol: "music.mic", background: AnyShapeStyle(.orange.gradient), symbolPadding: 32) }.padding().frame(width: 220)
}
#endif
