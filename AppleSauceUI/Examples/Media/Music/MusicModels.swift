import SwiftUI

struct MusicItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let eyebrow: String
    let symbol: String
    let artwork: ArtworkPalette
}

struct ConcertItem: Identifiable {
    let id: String
    let title: String
    let venue: String
    let schedule: String
    let month: String
    let day: Int
    let symbol: String
    let artwork: ArtworkPalette
}

struct MusicLibraryCategory: Identifiable {
    let id: String
    let title: LocalizedStringResource
    let symbol: String
}

struct MusicLink: Identifiable {
    let id: String
    let title: LocalizedStringResource
}

enum ArtworkPalette {
    case sunset
    case midnight
    case ocean
    case forest
    case amber
    case rose
    case violet
    case green
    case pink
    case orange
    case sepia
    case monochrome
}
