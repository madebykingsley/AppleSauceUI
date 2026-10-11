import SwiftUI

enum PodcastsFixtures {
    private static let songExploder = PodcastShowFixture(id: "song-exploder", title: "Song Exploder", category: "Music", publisher: "Radiotopia", updateInformation: "Updated 1d ago", symbol: "waveform", color: .purple, badge: nil)
    private static let theDaily = PodcastShowFixture(id: "daily", title: "The Daily", category: "News", publisher: "The New York Times", updateInformation: "Updated Weekly", symbol: "newspaper.fill", color: .cyan, badge: .video)
    private static let crimeJunkie = PodcastShowFixture(id: "crime-junkie", title: "Crime Junkie", category: "True Crime", publisher: "audiochuck", updateInformation: "Updated Weekly", symbol: "magnifyingglass", color: .indigo, badge: .explicit)
    private static let betterPerson = PodcastShowFixture(id: "better-person", title: "How to Be a Better Person", category: "Documentary", publisher: "TED", updateInformation: "Updated Weekly", symbol: "person.wave.2.fill", color: .blue, badge: nil)
    private static let liveAwake = PodcastShowFixture(id: "live-awake", title: "Live Awake", category: "Health & Fitness", publisher: "Sarah Blondin", updateInformation: "Updated 10/22/2020", symbol: "touchid", color: .gray, badge: nil)
    private static let timFerriss = PodcastShowFixture(id: "tim-ferriss", title: "The Tim Ferriss Show", category: "Health & Fitness", publisher: "Tim Ferriss", updateInformation: "Updated Daily", symbol: "figure.strengthtraining.traditional", color: .orange, badge: nil)
    private static let happyHour = PodcastShowFixture(id: "happy-hour", title: "Happy Hour", category: "Society & Culture", publisher: "Jessi Cruickshank", updateInformation: "Updated Weekly", symbol: "wineglass.fill", color: .pink, badge: .explicit)
    private static let dateline = PodcastShowFixture(id: "dateline", title: "Dateline NBC", category: "True Crime", publisher: "NBC News", updateInformation: "Updated Weekly", symbol: "eye.fill", color: .blue, badge: nil)
    private static let switchedOnPop = PodcastShowFixture(id: "switched-on-pop", title: "Switched on Pop", category: "Music Commentary", publisher: "Vulture", updateInformation: "Updated Weekly", symbol: "music.note", color: .mint, badge: nil)

    static let homeTopShows = [songExploder, timFerriss, theDaily, happyHour, switchedOnPop, betterPerson]
    static let homeVideoShows = [theDaily, betterPerson, songExploder, switchedOnPop, timFerriss]
    static let homeRecommendedShows = [betterPerson, liveAwake, timFerriss, happyHour, dateline, switchedOnPop]
    static let homePopularShows = [happyHour, timFerriss, crimeJunkie, dateline, theDaily, songExploder]
    static let homeMusicInterviews = [switchedOnPop, songExploder, timFerriss, happyHour, betterPerson]
    static let referenceShows = [songExploder, switchedOnPop, theDaily, crimeJunkie, happyHour, dateline]
    static let referenceSeed = timFerriss
    static let libraryShows = [betterPerson, songExploder, timFerriss, theDaily, switchedOnPop, liveAwake, dateline, happyHour]
    static let newTopShows = [theDaily, crimeJunkie, betterPerson, timFerriss, dateline, happyHour]
    static let newShows = [happyHour, betterPerson, liveAwake, switchedOnPop, songExploder, theDaily, crimeJunkie]
    static let newVideoShows = [theDaily, betterPerson, switchedOnPop, happyHour, songExploder]
    static let newTopSeries = [crimeJunkie, theDaily, dateline, liveAwake, timFerriss, happyHour]
    static let newHeritageShows = [happyHour, switchedOnPop, betterPerson, songExploder, theDaily, timFerriss]
    static let newTrueCrimeShows = [crimeJunkie, dateline, happyHour, theDaily]

    static let episodes = [
        PodcastEpisodeFixture(id: "ryen", title: "Talking CFPB, Falcons Down", show: "The Ryen Russillo Podcast", publisher: "The Ringer", episodeDate: "1d ago", description: "Ryen opens with the latest football news and listener questions.", duration: "23 min", symbol: "football.fill", color: .orange, badge: nil, progress: nil),
        PodcastEpisodeFixture(id: "hard-fork", title: "This Is Nuts: An OpenAI Insider Explains Why", show: "Hard Fork", publisher: "The New York Times", episodeDate: "1d ago", description: "A conversation about the fast-moving world of artificial intelligence.", duration: "1 hr", symbol: "cpu", color: .blue, badge: .explicit, progress: 0.22),
        PodcastEpisodeFixture(id: "daily-plane", title: "A Startled Farmer and an Iranian Plane", show: "The Daily", publisher: "The New York Times", episodeDate: "1d ago", description: "The surprising chain of events behind a story in the news.", duration: "32 min", symbol: "airplane", color: .cyan, badge: nil, progress: nil),
        PodcastEpisodeFixture(id: "parents", title: "Annoying Partners, Aging Parents, Impossible Coworkers", show: "The Mel Robbins Podcast", publisher: "SiriusXM", episodeDate: "Sep 20", description: "Practical advice for difficult conversations.", duration: "1h 13m", symbol: "person.2.fill", color: .pink, badge: nil, progress: 0.4),
        PodcastEpisodeFixture(id: "citizen", title: "Law Abiding Citizen with Bill Simmons, Van Lathan, and Chris Ryan", show: "The Rewatchables", publisher: "The Ringer", episodeDate: "Sep 21", description: "A spirited conversation about a memorable movie.", duration: "1h 39m", symbol: "film.fill", color: .green, badge: nil, progress: nil)
    ]
    static let homeMissedEpisodes = [episodes[1], episodes[3], episodes[2], episodes[4]]
    static let homeDiscoverEpisodes = [episodes[4], episodes[3], episodes[1], episodes[2]]
    static let recentlyPlayedEpisodes = [episodes[1], episodes[2], episodes[0]]
    static let trendingEpisodes = [episodes[0], episodes[1], episodes[2], episodes[3]]

    static let newPromotions = [
        PodcastPromotionFixture(id: "occupy", eyebrow: "New Season", title: "The protest that changed how we talk about wealth inequality.", symbol: "person.3.sequence.fill", color: .purple),
        PodcastPromotionFixture(id: "new-voices", eyebrow: "New This Week", title: "New voices, unforgettable stories, and conversations worth sharing.", symbol: "person.2.wave.2.fill", color: .cyan)
    ]
    static let upNextCards = [
        PodcastEpisodeCardFixture(id: "wtf", show: "WTF with Marc Maron", title: "Happy 17th Anniversary, WTF! On the WTF journey", episodeDate: "New · Sep 19", description: "Marc drops in to reflect on years of conversations.", duration: "23m", symbol: "mic.fill", color: .teal, badge: nil),
        PodcastEpisodeCardFixture(id: "songwriter", show: "Songwriter", title: "You're Not a Failure at Parenting", episodeDate: "Followed", description: "A thoughtful conversation about family and creativity.", duration: "33m", symbol: "music.mic", color: .blue, badge: nil)
    ]
    static let newsCards = [
        PodcastEpisodeCardFixture(id: "happiness", show: "How To!", title: "The Delivery Protection Act Takes on Amazon", episodeDate: "1d ago", description: "A conversation about policy, labor, and what comes next.", duration: "46m", symbol: "shippingbox.fill", color: .brown, badge: nil),
        PodcastEpisodeCardFixture(id: "daily-news", show: "The Daily", title: "What Changed This Week", episodeDate: "1d ago", description: "The stories shaping the week ahead.", duration: "1h 12m", symbol: "newspaper.fill", color: .gray, badge: nil)
    ]
    static let narratedArticleCards = [
        PodcastEpisodeCardFixture(id: "scorsese", show: "The New Yorker", title: "Year of the Horse", episodeDate: "2d ago", description: "From The New Yorker: After a young journalist was killed in a Central Park carriage accident this summer.", duration: "40m", symbol: "book.closed.fill", color: .red, badge: nil),
        PodcastEpisodeCardFixture(id: "culture", show: "The Atlantic", title: "The cure for the news hiding in plain sight", episodeDate: "2d ago", description: "A narrated essay about culture and attention.", duration: "39m", symbol: "text.book.closed.fill", color: .blue, badge: nil)
    ]
    static let momentCards = [
        PodcastEpisodeCardFixture(id: "texas", show: "The Moment", title: "Texas Is Testing the Power of MAGA Inc.'s Money", episodeDate: "Today", description: "President Trump is campaigning in Texas on Wednesday, rallying voters.", duration: "38m", symbol: "building.columns.fill", color: .indigo, badge: nil),
        PodcastEpisodeCardFixture(id: "blue-wave", show: "The Moment", title: "What Happens to the Blue Wave", episodeDate: "Today", description: "Voters weigh a changing political landscape.", duration: "31m", symbol: "person.3.fill", color: .blue, badge: nil)
    ]
    static let worthWatchingCards = [
        PodcastEpisodeCardFixture(id: "cancer", show: "HubMed", title: "Cancer Surgeon Dr. James Witting: I Was Hanging On by a Thread", episodeDate: "Sep 18", description: "Dr. James Witting tells his career story and what healing means.", duration: "46m", symbol: "stethoscope", color: .brown, badge: .video),
        PodcastEpisodeCardFixture(id: "christiane", show: "Talks", title: "The Christiane Amanpour Interview", episodeDate: "Sep 17", description: "A wide-ranging conversation about the news.", duration: "1h 24m", symbol: "video.fill", color: .orange, badge: .video)
    ]
    static let trailers = [
        PodcastTrailerFixture(id: "doomed", title: "Is the world ending, or does it just feel like it?", description: "Are We Doomed? investigates the greatest risks facing us.", duration: "Trailer", symbol: "globe.americas.fill", color: .orange),
        PodcastTrailerFixture(id: "dream", title: "What might a good future look like?", description: "Explore ideas about technology, society, and change.", duration: "Trailer", symbol: "sparkles", color: .teal)
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
        PodcastChannelFixture(id: "sirius", title: "SiriusXM Podcasts", description: "The best in comedy, sports, talk, news, and entertainment.", symbol: "dot.radiowaves.left.and.right", color: .blue),
        PodcastChannelFixture(id: "sc", title: "SC Media", description: "Podcasts from researchers and creators.", symbol: "waveform", color: .indigo)
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
