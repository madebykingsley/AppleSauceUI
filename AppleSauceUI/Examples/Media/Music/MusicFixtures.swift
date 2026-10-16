import SwiftUI

enum MusicFixtures {
    static let glasshouseWeather = MusicItem(id: "glasshouse-weather", title: "Glasshouse Weather", subtitle: "Mara Voss", eyebrow: "", symbol: "cloud.sun.fill", artwork: .ocean, artworkName: "MusicGlasshouseWeather")
    static let neonApricot = MusicItem(id: "neon-apricot", title: "Neon Apricot", subtitle: "Atlas Bloom", eyebrow: "", symbol: "sun.max.fill", artwork: .orange, artworkName: "MusicNeonApricot")
    static let lettersFromLowTide = MusicItem(id: "letters-from-low-tide", title: "Letters from Low Tide", subtitle: "Harborlight", eyebrow: "", symbol: "water.waves", artwork: .ocean, artworkName: "MusicLettersFromLowTide")
    static let midnightInCopper = MusicItem(id: "midnight-in-copper", title: "Midnight in Copper", subtitle: "Cedar Arcade", eyebrow: "", symbol: "moon.stars.fill", artwork: .amber, artworkName: "MusicMidnightInCopper")
    static let everythingIsBlooming = MusicItem(id: "everything-is-blooming", title: "Everything Is Blooming", subtitle: "Juniper Vale", eyebrow: "", symbol: "camera.macro", artwork: .rose, artworkName: "MusicEverythingIsBlooming")
    static let slowElectric = MusicItem(id: "slow-electric", title: "Slow Electric", subtitle: "North Arcade", eyebrow: "", symbol: "bolt.fill", artwork: .violet, artworkName: "MusicSlowElectric")
    static let lastSunMotel = MusicItem(id: "the-last-sun-motel", title: "The Last Sun Motel", subtitle: "Theo March", eyebrow: "", symbol: "sun.haze.fill", artwork: .sunset, artworkName: "MusicLastSunMotel")
    static let honeyOnSaturn = MusicItem(id: "honey-on-saturn", title: "Honey on Saturn", subtitle: "Lena Vale", eyebrow: "", symbol: "sparkles", artwork: .amber, artworkName: "MusicHoneyOnSaturn")
    static let pocketThunder = MusicItem(id: "pocket-thunder", title: "Pocket Thunder", subtitle: "Stone & Signal", eyebrow: "", symbol: "cloud.bolt.fill", artwork: .midnight, artworkName: "MusicPocketThunder")
    static let blueHourArcade = MusicItem(id: "blue-hour-arcade", title: "Blue Hour Arcade", subtitle: "Static Gardens", eyebrow: "", symbol: "arcade.stick", artwork: .ocean, artworkName: "MusicBlueHourArcade")
    static let wildflowerStatic = MusicItem(id: "wildflower-static", title: "Wildflower Static", subtitle: "Paper Moons", eyebrow: "", symbol: "leaf.fill", artwork: .forest, artworkName: "MusicWildflowerStatic")
    static let mapOfQuiet = MusicItem(id: "a-map-of-quiet", title: "A Map of Quiet", subtitle: "Ellis North", eyebrow: "", symbol: "map.fill", artwork: .sepia, artworkName: "MusicMapOfQuiet")

    static let libraryCategories = [
        MusicLibraryCategory(id: "playlists", title: "Playlists", symbol: "music.note.list"),
        MusicLibraryCategory(id: "artists", title: "Artists", symbol: "music.microphone"),
        MusicLibraryCategory(id: "albums", title: "Albums", symbol: "rectangle.stack"),
        MusicLibraryCategory(id: "made-for-you", title: "Made for You", symbol: "person.crop.square"),
        MusicLibraryCategory(id: "songs", title: "Songs", symbol: "music.note"),
        MusicLibraryCategory(id: "tv-movies", title: "TV & Movies", symbol: "tv"),
        MusicLibraryCategory(id: "genres", title: "Genres", symbol: "guitars"),
        MusicLibraryCategory(id: "downloaded", title: "Downloaded", symbol: "arrow.down.circle")
    ]

    static let topPicks = [
        MusicItem(id: "essentials", title: "Your Essentials", subtitle: "Harborlight, Juniper Vale, North Arcade, Paper Moons, and more", eyebrow: "Made for You", symbol: "sparkles", artwork: .violet),
        MusicItem(id: "energy", title: "Energy", subtitle: "Keep it moving with guitar-driven favorites.", eyebrow: "Mood for You", symbol: "bolt", artwork: .green),
        MusicItem(id: "get-up", title: "Get Up!", subtitle: "Harborlight, North Arcade, Juniper Vale, Paper Moons, Stone & Signal, and more", eyebrow: "Made for You", symbol: "figure.run", artwork: .sunset)
    ]

    static let recentlyPlayed = [
        glasshouseWeather,
        neonApricot,
        lettersFromLowTide
    ]

    static let nineties = [
        midnightInCopper,
        everythingIsBlooming,
        slowElectric
    ]

    static let prisoner = lastSunMotel

    static let moreLikePrisoner = [
        honeyOnSaturn,
        pocketThunder,
        blueHourArcade
    ]

    static let playlists = [
        topPicks[0],
        topPicks[2],
        MusicItem(id: "favorites", title: "Favorites Mix", subtitle: "Made for You", eyebrow: "", symbol: "heart.fill", artwork: .rose)
    ]

    static let stations = [
        MusicItem(id: "personal-station", title: "Your Station", subtitle: "Radio Station", eyebrow: "", symbol: "forward.fill", artwork: .sunset),
        MusicItem(id: "discovery", title: "Discovery Station", subtitle: "Radio Station", eyebrow: "", symbol: "play.fill", artwork: .violet),
        MusicItem(id: "harborlight", title: "Harborlight Station", subtitle: "Radio Station", eyebrow: "", symbol: "waveform", artwork: .ocean)
    ]

    static let moods = [
        MusicItem(id: "mood-energy", title: "Energy", subtitle: "Radio Station", eyebrow: "", symbol: "bolt", artwork: .green),
        MusicItem(id: "mood-love", title: "Love", subtitle: "Radio Station", eyebrow: "", symbol: "heart", artwork: .pink),
        MusicItem(id: "mood-focus", title: "Focus", subtitle: "Radio Station", eyebrow: "", symbol: "circle.hexagongrid", artwork: .orange)
    ]

    static let newReleases = [
        wildflowerStatic,
        mapOfQuiet,
        glasshouseWeather
    ]

    static let concerts = [
        ConcertItem(id: "local-h", title: "Fallow Street", venue: "Canyon Lantern Hall", schedule: "Tue, Oct 6 · 8 PM", month: "Oct", day: 6, symbol: "person.fill", artwork: .monochrome, artworkName: "MusicPocketThunder"),
        ConcertItem(id: "toadies", title: "Limestone Radio", venue: "Canyon Lantern Hall", schedule: "Tue, Oct 6 · 7 PM", month: "Oct", day: 6, symbol: "person.3.fill", artwork: .midnight, artworkName: "MusicBlueHourArcade"),
        ConcertItem(id: "dan", title: "Theo March", venue: "The Meridian Room", schedule: "Fri, Oct 9 · 8 PM", month: "Oct", day: 9, symbol: "music.mic", artwork: .ocean, artworkName: "MusicWildflowerStatic")
    ]

    static let replay = [
        MusicItem(id: "september", title: "Your September Replay is here.", subtitle: "Replay the artists, songs, and albums that defined your month.", eyebrow: "Replay Monthly", symbol: "arrow.counterclockwise", artwork: .sunset),
        MusicItem(id: "all-time", title: "Replay All Time", subtitle: "Harborlight, Cedar Arcade, Of Monsters and Men, and more", eyebrow: "Replay", symbol: "infinity", artwork: .ocean)
    ]

    static let newHeroItems = [
        MusicItem(id: "alt-ctrl", title: "ALT\nCTRL", subtitle: "Nova Grey gives a nursery rhyme a powerful update with “Roses.”", eyebrow: "Updated Playlist", symbol: "waveform", artwork: .monochrome),
        MusicItem(id: "new-alt", title: "NEW\nMUSIC", subtitle: "The songs defining this week.", eyebrow: "New Music Daily", symbol: "music.note", artwork: .rose),
        MusicItem(id: "k-pop", title: "KPOP WORLD", subtitle: "Your go-to destination for all things K-pop.", eyebrow: "Updated Playlist", symbol: "music.note", artwork: .amber)
    ]

    static let bestNewSongs = [
        glasshouseWeather,
        neonApricot,
        lettersFromLowTide,
        midnightInCopper,
        everythingIsBlooming,
        slowElectric,
        lastSunMotel,
        honeyOnSaturn,
        pocketThunder,
        blueHourArcade,
        wildflowerStatic,
        mapOfQuiet
    ]

    static let newThisWeek = [
        pocketThunder,
        blueHourArcade,
        wildflowerStatic
    ]

    static let recentReleases = [
        mapOfQuiet,
        glasshouseWeather,
        neonApricot
    ]

    static let interviews = [
        MusicItem(id: "mara-interview", title: "Mara Voss: Inside Glasshouse Weather", subtitle: "Mara Voss & Eli Hart", eyebrow: "", symbol: "mic.fill", artwork: .monochrome, artworkName: "MusicGlasshouseWeather"),
        MusicItem(id: "len-interview", title: "The Story of A Map of Quiet", subtitle: "Ellis North & Eli Hart", eyebrow: "", symbol: "person.2.fill", artwork: .ocean, artworkName: "MusicMapOfQuiet"),
        MusicItem(id: "nova-interview", title: "Behind Neon Apricot", subtitle: "Atlas Bloom & Eli Hart", eyebrow: "", symbol: "quote.bubble.fill", artwork: .rose, artworkName: "MusicNeonApricot")
    ]

    static let musicVideos = [
        MusicItem(id: "glasshouse-video", title: "Glasshouse Weather", subtitle: "Mara Voss", eyebrow: "", symbol: "play.rectangle.fill", artwork: .rose, artworkName: "MusicGlasshouseWeather"),
        MusicItem(id: "low-tide-video", title: "Letters from Low Tide", subtitle: "Harborlight", eyebrow: "", symbol: "play.rectangle.fill", artwork: .forest, artworkName: "MusicLettersFromLowTide"),
        MusicItem(id: "slow-electric-video", title: "Slow Electric", subtitle: "North Arcade", eyebrow: "", symbol: "play.rectangle.fill", artwork: .ocean, artworkName: "MusicSlowElectric")
    ]

    static let comingSoon = [
        lastSunMotel,
        honeyOnSaturn,
        pocketThunder
    ]

    static let recentlyAdded = [
        glasshouseWeather,
        neonApricot,
        lettersFromLowTide,
        midnightInCopper,
        everythingIsBlooming,
        slowElectric,
        lastSunMotel,
        honeyOnSaturn,
        pocketThunder,
        blueHourArcade,
        wildflowerStatic,
        mapOfQuiet
    ]
}

extension ArtworkPalette {
    var colors: [Color] {
        switch self {
        case .sunset: [.red, .orange, .yellow]
        case .midnight: [.black, .indigo, .gray]
        case .ocean: [.blue, .cyan, .mint]
        case .forest: [.green, .teal, .black]
        case .amber: [.orange, .yellow, .red]
        case .rose: [.pink, .red, .purple]
        case .violet: [.purple, .indigo, .blue]
        case .green: [.green, .green, .black]
        case .pink: [.pink, .pink, .white]
        case .orange: [.orange, .orange, .yellow]
        case .sepia: [.brown, .gray, .black]
        case .monochrome: [.black, .gray, .white]
        }
    }

    var accent: Color { colors.last ?? .white }

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
