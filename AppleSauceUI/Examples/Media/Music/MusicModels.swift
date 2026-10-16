import SwiftUI

struct MusicItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let eyebrow: String
    let symbol: String
    let artwork: ArtworkPalette
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "MusicNightTrain" : "MusicPrismLight")
    }
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
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "EpisodeCoastalTrail" : "EditorialLivingArchive")
    }
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
