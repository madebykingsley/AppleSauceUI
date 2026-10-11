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

extension PodcastShowFixture {
    func tilePresentation(hierarchy: MediaTilePresentation.Hierarchy = .standard) -> MediaTilePresentation {
        let secondary: String
        let tertiary: String?
        switch hierarchy {
        case .standard:
            secondary = category
            tertiary = updateInformation
        case .ranked:
            secondary = publisher
            tertiary = nil
        case .library:
            secondary = updateInformation
            tertiary = nil
        }
        return MediaTilePresentation(
            title: title,
            secondaryText: secondary,
            tertiaryText: tertiary,
            badge: badge?.compactText,
            badgeAccessibilityLabel: badge?.accessibilityName,
            hierarchy: hierarchy
        )
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
}

struct PodcastPromotionFixture: Identifiable {
    let id: String
    let eyebrow: String
    let title: String
    let symbol: String
    let color: Color
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
}

struct PodcastTrailerFixture: Identifiable {
    let id: String
    let title: String
    let description: String
    let duration: String
    let symbol: String
    let color: Color
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
