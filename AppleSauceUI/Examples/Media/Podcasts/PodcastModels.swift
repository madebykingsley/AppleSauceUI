import SwiftUI

struct PodcastShowFixture: Identifiable {
    let id: String
    let title: String
    let category: String
    let publisher: String
    let updateInformation: String
    let symbol: String
    let color: Color
    let badge: PodcastShowBadgeKind?
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "PodcastFieldNotes" : "PodcastSignalCities")
    }
}

enum PodcastShowBadgeKind {
    case video
    case explicit

    var label: LocalizedStringKey {
        switch self {
        case .video: "Video"
        case .explicit: "Explicit"
        }
    }

    var accessibilityName: String {
        switch self {
        case .video: "video"
        case .explicit: "explicit"
        }
    }
}

extension PodcastShowBadgeKind {
    var compactText: String {
        switch self {
        case .video: "Video"
        case .explicit: "E"
        }
    }
}

struct PodcastEpisodeFixture: Identifiable {
    let id: String
    let title: String
    let show: String
    let publisher: String
    let episodeDate: String
    let description: String
    let duration: String
    let symbol: String
    let color: Color
    let badge: PodcastShowBadgeKind?
    let progress: Double?
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "EpisodeCoastalTrail" : "EditorialLivingArchive")
    }
}

struct PodcastPromotionFixture: Identifiable {
    let id: String
    let eyebrow: String
    let title: String
    let symbol: String
    let color: Color
    var artworkName: String? = nil
}

struct PodcastEpisodeCardFixture: Identifiable {
    let id: String
    let show: String
    let title: String
    let episodeDate: String
    let description: String
    let duration: String
    let symbol: String
    let color: Color
    let badge: PodcastShowBadgeKind?
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "EpisodeCoastalTrail" : "EditorialLivingArchive")
    }
}

struct PodcastTrailerFixture: Identifiable {
    let id: String
    let title: String
    let description: String
    let duration: String
    let symbol: String
    let color: Color
    var artworkName: String? = nil

    var resolvedArtworkName: String? {
        artworkName ?? (id.count.isMultiple(of: 2) ? "EpisodeCoastalTrail" : "EditorialLivingArchive")
    }
}

struct PodcastCategoryFixture: Identifiable {
    let id: String
    let title: LocalizedStringResource
    let symbol: String
}

struct PodcastChannelFixture: Identifiable {
    let id: String
    let title: String
    let description: String
    let symbol: String
    let color: Color
}

struct PodcastDiscoveryFixture: Identifiable {
    let id: String
    let title: String
    let symbol: String
    let color: Color
}

struct PodcastQuickLinkFixture: Identifiable {
    let id: String
    let title: LocalizedStringResource
}

struct PodcastSearchCategory: Identifiable {
    let id: String
    let title: LocalizedStringResource
    let symbol: String
    let color: Color
}
