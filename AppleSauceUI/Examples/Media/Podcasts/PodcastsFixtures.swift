import SwiftUI

enum PodcastsFixtures {
    private static let velvetOrbit = PodcastShowFixture(id: "velvet-orbit", title: "Velvet Orbit", category: "Science", publisher: "Northstar Audio", updateInformation: "Updated weekly", symbol: "sparkles", color: .purple, badge: nil, artworkName: "PodcastVelvetOrbit")
    private static let sundayLadle = PodcastShowFixture(id: "sunday-ladle", title: "The Sunday Ladle", category: "Food", publisher: "Kitchen Window Studio", updateInformation: "Updated Sundays", symbol: "fork.knife", color: .orange, badge: .video, artworkName: "PodcastSundayLadle")
    private static let sidewalkAtlas = PodcastShowFixture(id: "sidewalk-atlas", title: "Sidewalk Atlas", category: "Society & Culture", publisher: "Corner Map Media", updateInformation: "Updated twice monthly", symbol: "map.fill", color: .cyan, badge: nil, artworkName: "PodcastSidewalkAtlas")
    private static let mossMinutes = PodcastShowFixture(id: "moss-minutes", title: "Moss & Minutes", category: "Nature", publisher: "Fieldglass Audio", updateInformation: "New episodes every Tuesday", symbol: "leaf.fill", color: .green, badge: nil, artworkName: "PodcastMossMinutes")
    private static let staticAfterDark = PodcastShowFixture(id: "static-after-dark", title: "Static After Dark", category: "Fiction", publisher: "Night Dial Studio", updateInformation: "Updated Fridays", symbol: "waveform", color: .indigo, badge: .explicit, artworkName: "PodcastStaticAfterDark")
    private static let tinyRevolutions = PodcastShowFixture(id: "tiny-revolutions", title: "Tiny Revolutions", category: "Documentary", publisher: "Common Thread Studio", updateInformation: "Updated weekly", symbol: "arrow.trianglehead.2.clockwise.rotate.90", color: .red, badge: nil, artworkName: "PodcastTinyRevolutions")
    private static let paperComet = PodcastShowFixture(id: "paper-comet", title: "The Paper Comet", category: "Arts", publisher: "Folded Light Audio", updateInformation: "Updated monthly", symbol: "paperplane.fill", color: .pink, badge: nil, artworkName: "PodcastPaperComet")
    private static let offbeatAssembly = PodcastShowFixture(id: "offbeat-assembly", title: "Offbeat Assembly", category: "Music", publisher: "Side Door Sessions", updateInformation: "Updated Wednesdays", symbol: "music.note", color: .mint, badge: .video, artworkName: "PodcastOffbeatAssembly")
    private static let futureOrchard = PodcastShowFixture(id: "future-orchard", title: "Future Orchard", category: "Technology", publisher: "Tomorrow Field", updateInformation: "Updated weekdays", symbol: "tree.fill", color: .green, badge: nil, artworkName: "PodcastFutureOrchard")
    private static let detourClub = PodcastShowFixture(id: "detour-club", title: "Detour Club", category: "Travel", publisher: "Elsewhere Audio", updateInformation: "Updated every other week", symbol: "road.lanes.curved.right", color: .blue, badge: nil, artworkName: "PodcastDetourClub")
    private static let softLaunchLife = PodcastShowFixture(id: "soft-launch-life", title: "Soft Launch Life", category: "Comedy", publisher: "Low Stakes Media", updateInformation: "Updated weekly", symbol: "party.popper.fill", color: .yellow, badge: .explicit, artworkName: "PodcastSoftLaunchLife")
    private static let underFloorboards = PodcastShowFixture(id: "under-floorboards", title: "Under the Floorboards", category: "True Crime", publisher: "Lantern Audio", updateInformation: "Updated weekly", symbol: "magnifyingglass", color: .brown, badge: nil, artworkName: "PodcastUnderFloorboards")

    static let homeTopShows = [velvetOrbit, sundayLadle, sidewalkAtlas, mossMinutes, staticAfterDark, tinyRevolutions]
    static let homeVideoShows = [sundayLadle, offbeatAssembly, paperComet, futureOrchard, velvetOrbit]
    static let homeRecommendedShows = [mossMinutes, detourClub, softLaunchLife, paperComet, futureOrchard, sidewalkAtlas]
    static let homePopularShows = [staticAfterDark, velvetOrbit, underFloorboards, sundayLadle, tinyRevolutions, offbeatAssembly]
    static let homeMusicInterviews = [offbeatAssembly, paperComet, velvetOrbit, softLaunchLife, sidewalkAtlas]
    static let referenceShows = [velvetOrbit, sidewalkAtlas, staticAfterDark, underFloorboards, softLaunchLife, detourClub]
    static let referenceSeed = futureOrchard
    static let libraryShows = [mossMinutes, velvetOrbit, futureOrchard, sundayLadle, offbeatAssembly, detourClub, underFloorboards, softLaunchLife]
    static let newTopShows = [sundayLadle, underFloorboards, tinyRevolutions, velvetOrbit, staticAfterDark, softLaunchLife]
    static let newShows = [softLaunchLife, mossMinutes, detourClub, offbeatAssembly, paperComet, sidewalkAtlas, underFloorboards]
    static let newVideoShows = [sundayLadle, offbeatAssembly, tinyRevolutions, softLaunchLife, velvetOrbit]
    static let newTopSeries = [underFloorboards, staticAfterDark, sidewalkAtlas, detourClub, futureOrchard, paperComet]
    static let newHeritageShows = [sidewalkAtlas, sundayLadle, mossMinutes, offbeatAssembly, paperComet, detourClub]
    static let newTrueCrimeShows = [underFloorboards, staticAfterDark, detourClub, sidewalkAtlas]

    static let episodes = [
        PodcastEpisodeFixture(id: "late-train", title: "The Last Train Through Arroyo County", show: "Detour Club", publisher: "Elsewhere Audio", episodeDate: "Yesterday", description: "A night journey reveals why one rural rail line still matters.", duration: "23 min", symbol: "tram.fill", color: .orange, badge: nil, progress: nil, artworkName: "PodcastDetourClub"),
        PodcastEpisodeFixture(id: "model-town", title: "The Model That Tried to Run a Small Town", show: "Future Orchard", publisher: "Tomorrow Field", episodeDate: "Yesterday", description: "Residents test an ambitious civic experiment and discover its blind spots.", duration: "1 hr", symbol: "cpu", color: .blue, badge: .explicit, progress: 0.22, artworkName: "PodcastFutureOrchard"),
        PodcastEpisodeFixture(id: "weather-station", title: "The Weather Station at the Edge of the Sea", show: "Moss & Minutes", publisher: "Fieldglass Audio", episodeDate: "Yesterday", description: "The observers recording a coastline in rapid transition.", duration: "32 min", symbol: "cloud.sun.fill", color: .cyan, badge: nil, progress: nil, artworkName: "PodcastMossMinutes"),
        PodcastEpisodeFixture(id: "parents", title: "Annoying Partners, Aging Parents, Impossible Coworkers", show: "Soft Launch Life", publisher: "Low Stakes Media", episodeDate: "Sep 20", description: "Practical advice for difficult conversations.", duration: "1h 13m", symbol: "person.2.fill", color: .pink, badge: nil, progress: 0.4, artworkName: "PodcastSoftLaunchLife"),
        PodcastEpisodeFixture(id: "citizen", title: "A Movie Argument with Avery Cole, Micah Reed, and Tessa Ward", show: "Static After Dark", publisher: "Night Dial Studio", episodeDate: "Sep 21", description: "A spirited conversation about a memorable movie.", duration: "1h 39m", symbol: "film.fill", color: .green, badge: nil, progress: nil, artworkName: "PodcastStaticAfterDark")
    ]
    static let homeMissedEpisodes = [episodes[1], episodes[3], episodes[2], episodes[4]]
    static let homeDiscoverEpisodes = [episodes[4], episodes[3], episodes[1], episodes[2]]
    static let recentlyPlayedEpisodes = [episodes[1], episodes[2], episodes[0]]
    static let trendingEpisodes = [episodes[0], episodes[1], episodes[2], episodes[3]]

    static let newPromotions = [
        PodcastPromotionFixture(id: "living-archive", eyebrow: "New Season", title: "Inside the living archive connecting forgotten stories across generations.", symbol: "archivebox.fill", color: .purple),
        PodcastPromotionFixture(id: "new-voices", eyebrow: "New This Week", title: "New voices, unforgettable stories, and conversations worth sharing.", symbol: "person.2.wave.2.fill", color: .cyan)
    ]
    static let upNextCards = [
        PodcastEpisodeCardFixture(id: "orbit-listener", show: "Velvet Orbit", title: "The Listener Beyond the Kuiper Belt", episodeDate: "New · Sep 19", description: "A signal analyst reflects on years of listening to the quietest corners of space.", duration: "23m", symbol: "antenna.radiowaves.left.and.right", color: .teal, badge: nil, artworkName: "PodcastVelvetOrbit"),
        PodcastEpisodeCardFixture(id: "sunday-table", show: "The Sunday Ladle", title: "The Soup That Starts Before Sunrise", episodeDate: "Followed", description: "A thoughtful conversation about family recipes and the people who preserve them.", duration: "33m", symbol: "fork.knife", color: .blue, badge: nil, artworkName: "PodcastSundayLadle")
    ]
    static let newsCards = [
        PodcastEpisodeCardFixture(id: "small-change", show: "Tiny Revolutions", title: "The Neighborhood That Rewrote Its Delivery Rules", episodeDate: "1d ago", description: "A conversation about policy, labor, and what comes next.", duration: "46m", symbol: "shippingbox.fill", color: .brown, badge: nil, artworkName: "PodcastTinyRevolutions"),
        PodcastEpisodeCardFixture(id: "sidewalk-week", show: "Sidewalk Atlas", title: "What Changed on This Block This Week", episodeDate: "1d ago", description: "The street-level stories shaping the week ahead.", duration: "1h 12m", symbol: "newspaper.fill", color: .gray, badge: nil, artworkName: "PodcastSidewalkAtlas")
    ]
    static let narratedArticleCards = [
        PodcastEpisodeCardFixture(id: "paper-year", show: "The Paper Comet", title: "The Year the Sketchbook Wouldn't Close", episodeDate: "2d ago", description: "A narrated profile of an illustrator building a world one page at a time.", duration: "40m", symbol: "book.closed.fill", color: .red, badge: nil, artworkName: "PodcastPaperComet"),
        PodcastEpisodeCardFixture(id: "hidden-news", show: "Under the Floorboards", title: "The Clue Hiding in Plain Sight", episodeDate: "2d ago", description: "A narrated investigation about memory, attention, and an overlooked room.", duration: "39m", symbol: "text.book.closed.fill", color: .blue, badge: nil, artworkName: "PodcastUnderFloorboards")
    ]
    static let momentCards = [
        PodcastEpisodeCardFixture(id: "night-signal", show: "Static After Dark", title: "The Frequency Nobody Was Supposed to Hear", episodeDate: "Today", description: "A late-night engineer traces an impossible broadcast across the city.", duration: "38m", symbol: "waveform", color: .indigo, badge: nil, artworkName: "PodcastStaticAfterDark"),
        PodcastEpisodeCardFixture(id: "detour-vote", show: "Detour Club", title: "When the Highway Bypassed Main Street", episodeDate: "Today", description: "Residents weigh the promises and costs of a changing route.", duration: "31m", symbol: "road.lanes", color: .blue, badge: nil, artworkName: "PodcastDetourClub")
    ]
    static let worthWatchingCards = [
        PodcastEpisodeCardFixture(id: "orchard-roots", show: "Future Orchard", title: "Can an Orchard Predict Its Own Future?", episodeDate: "Sep 18", description: "A field scientist explains what roots, sensors, and seasons can teach us.", duration: "46m", symbol: "tree.fill", color: .brown, badge: .video, artworkName: "PodcastFutureOrchard"),
        PodcastEpisodeCardFixture(id: "assembly-interview", show: "Offbeat Assembly", title: "The Mira Sayeed Interview", episodeDate: "Sep 17", description: "A wide-ranging conversation about collaboration and sound.", duration: "1h 24m", symbol: "video.fill", color: .orange, badge: .video, artworkName: "PodcastOffbeatAssembly")
    ]
    static let trailers = [
        PodcastTrailerFixture(id: "floorboards-trailer", title: "What has been waiting under the floorboards?", description: "A new investigation follows the clues a renovated house refused to surrender.", duration: "Trailer", symbol: "magnifyingglass", color: .orange, artworkName: "PodcastUnderFloorboards"),
        PodcastTrailerFixture(id: "soft-launch-trailer", title: "What if being unfinished is the whole point?", description: "Soft Launch Life explores work, friendship, and plans still taking shape.", duration: "Trailer", symbol: "sparkles", color: .teal, artworkName: "PodcastSoftLaunchLife")
    ]

    static let categories = [
        PodcastCategoryFixture(id: "latest", title: "Latest Episodes", symbol: "clock"),
        PodcastCategoryFixture(id: "channels", title: "Channels", symbol: "slider.horizontal.3"),
        PodcastCategoryFixture(id: "categories", title: "Categories", symbol: "square.stack.3d.up"),
        PodcastCategoryFixture(id: "saved", title: "Saved", symbol: "bookmark.fill"),
        PodcastCategoryFixture(id: "shows", title: "Shows", symbol: "rectangle.stack"),
        PodcastCategoryFixture(id: "downloaded", title: "Downloaded", symbol: "arrow.down.circle.fill")
    ]
    static let channels = [
        PodcastChannelFixture(id: "sirius", title: "Side Street Podcasts", description: "The best in comedy, sports, talk, news, and entertainment.", symbol: "dot.radiowaves.left.and.right", color: .blue),
        PodcastChannelFixture(id: "sc", title: "Common Thread Media", description: "Podcasts from researchers and creators.", symbol: "waveform", color: .indigo)
    ]
    static let discovery = [
        PodcastDiscoveryFixture(id: "video", title: "Video", symbol: "video.fill", color: .orange),
        PodcastDiscoveryFixture(id: "articles", title: "Articles", symbol: "text.book.closed.fill", color: .pink),
        PodcastDiscoveryFixture(id: "history", title: "History", symbol: "clock.arrow.circlepath", color: .blue)
    ]
    static let quickLinks = [
        PodcastQuickLinkFixture(id: "charts", title: "Top Charts"),
        PodcastQuickLinkFixture(id: "language", title: "Podcasts by Language"),
        PodcastQuickLinkFixture(id: "creators", title: "For Creators")
    ]

    enum StressTests {
        static let longShow = PodcastShowFixture(id: "long-show", title: "A Show Title Long Enough to Exercise Metadata Wrapping", category: "Documentary", publisher: "A Publisher With a Long Name", updateInformation: "New episodes every weekday with extended metadata", symbol: "text.bubble.fill", color: .blue, badge: .explicit)
        static let longEpisodeCard = PodcastEpisodeCardFixture(id: "long-card", show: "A Show With an Intentionally Long Name", title: "An Episode Title Long Enough to Exercise Several Lines of Card Layout", episodeDate: "Today", description: "A deliberately extended description that verifies the rounded card remains coherent when text grows and Dynamic Type is enabled.", duration: "1h 48m", symbol: "text.bubble.fill", color: .indigo, badge: .video)
    }
}
