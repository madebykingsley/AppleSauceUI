import SwiftUI

struct StyleProfileMediaItem: Identifiable {
    let id: String
    let title: String
    let creator: String
    let symbol: String
    let colors: [Color]

    static let samples = [
        StyleProfileMediaItem(
            id: "distant-light",
            title: "Distant Light",
            creator: "Mira Vale",
            symbol: "sparkles",
            colors: [.indigo, .cyan]
        ),
        StyleProfileMediaItem(
            id: "open-water",
            title: "Open Water",
            creator: "Northline",
            symbol: "water.waves",
            colors: [.blue, .mint]
        ),
        StyleProfileMediaItem(
            id: "after-hours",
            title: "After Hours",
            creator: "Signal Path",
            symbol: "moon.stars.fill",
            colors: [.purple, .orange]
        ),
        StyleProfileMediaItem(
            id: "green-room",
            title: "Green Room",
            creator: "Field Notes",
            symbol: "leaf.fill",
            colors: [.green, .yellow]
        )
    ]
}
