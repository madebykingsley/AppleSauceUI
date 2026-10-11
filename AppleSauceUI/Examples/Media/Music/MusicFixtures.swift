import SwiftUI

enum MusicFixtures {
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
        MusicItem(id: "essentials", title: "Your Essentials", subtitle: "Ryan Adams, Sparta, Silversun Pickups, The Strokes, Radiohead, Death Cab for Cutie, and more", eyebrow: "Made for You", symbol: "sparkles", artwork: .violet),
        MusicItem(id: "energy", title: "Energy", subtitle: "Keep it moving with guitar-driven favorites.", eyebrow: "Mood for You", symbol: "bolt", artwork: .green),
        MusicItem(id: "get-up", title: "Get Up!", subtitle: "Pearl Jam, Incubus, Blind Melon, Nada Surf, Soundgarden, and more", eyebrow: "Made for You", symbol: "figure.run", artwork: .sunset)
    ]

    static let recentlyPlayed = [
        MusicItem(id: "bob-marley", title: "Bob Marley Essentials", subtitle: "Apple Music Reggae", eyebrow: "", symbol: "sun.max.fill", artwork: .forest),
        MusicItem(id: "heavy-rotation", title: "Heavy Rotation", subtitle: "Apple Music for Kingsley…", eyebrow: "", symbol: "repeat", artwork: .amber),
        MusicItem(id: "90s-country", title: "90’s Country", subtitle: "Apple Music Country", eyebrow: "", symbol: "music.mic", artwork: .rose)
    ]

    static let nineties = [
        MusicItem(id: "1979", title: "1979 Mixes - EP", subtitle: "The Smashing Pumpkins", eyebrow: "", symbol: "record.circle", artwork: .midnight),
        MusicItem(id: "promises", title: "Promises Broken EP - EP", subtitle: "Soul Asylum", eyebrow: "", symbol: "guitars.fill", artwork: .rose),
        MusicItem(id: "gin", title: "’Til I Hear It From You", subtitle: "Gin Blossoms", eyebrow: "", symbol: "music.note", artwork: .amber)
    ]

    static let prisoner = MusicItem(
        id: "prisoner",
        title: "Prisoner",
        subtitle: "Ryan Adams",
        eyebrow: "",
        symbol: "person.crop.square",
        artwork: .rose
    )

    static let moreLikePrisoner = [
        MusicItem(id: "sleep-well", title: "Sleep Well Beast", subtitle: "The National", eyebrow: "", symbol: "mountain.2.fill", artwork: .midnight),
        MusicItem(id: "deeper", title: "A Deeper Understanding", subtitle: "The War on Drugs", eyebrow: "", symbol: "car.fill", artwork: .amber),
        MusicItem(id: "integrity", title: "Integrity Blues", subtitle: "Jimmy Eat World", eyebrow: "", symbol: "circle.grid.cross.fill", artwork: .ocean)
    ]

    static let playlists = [
        topPicks[0],
        topPicks[2],
        MusicItem(id: "favorites", title: "Favorites Mix", subtitle: "Made for You", eyebrow: "", symbol: "heart.fill", artwork: .rose)
    ]

    static let stations = [
        MusicItem(id: "personal-station", title: "Kingsley Wientge’s Station", subtitle: "Radio Station", eyebrow: "", symbol: "forward.fill", artwork: .sunset),
        MusicItem(id: "discovery", title: "Discovery Station", subtitle: "Radio Station", eyebrow: "", symbol: "play.fill", artwork: .violet),
        MusicItem(id: "pearl-jam", title: "Pearl Jam Station", subtitle: "Radio Station", eyebrow: "", symbol: "waveform", artwork: .ocean)
    ]

    static let moods = [
        MusicItem(id: "mood-energy", title: "Energy", subtitle: "Radio Station", eyebrow: "", symbol: "bolt", artwork: .green),
        MusicItem(id: "mood-love", title: "Love", subtitle: "Radio Station", eyebrow: "", symbol: "heart", artwork: .pink),
        MusicItem(id: "mood-focus", title: "Focus", subtitle: "Radio Station", eyebrow: "", symbol: "circle.hexagongrid", artwork: .orange)
    ]

    static let newReleases = [
        MusicItem(id: "recuerda", title: "Recuerda Tu Muerte", subtitle: "Sponge", eyebrow: "", symbol: "waveform", artwork: .midnight),
        MusicItem(id: "perfect-circle", title: "To Whom It May Concern", subtitle: "A Perfect Circle", eyebrow: "", symbol: "bird.fill", artwork: .sepia),
        MusicItem(id: "hen", title: "Hen’s Teeth", subtitle: "Iron & Wine", eyebrow: "", symbol: "leaf.fill", artwork: .rose)
    ]

    static let concerts = [
        ConcertItem(id: "local-h", title: "Local H", venue: "Pappy & Harriet’s", schedule: "Tue, Oct 6 · 8 PM", month: "Oct", day: 6, symbol: "person.fill", artwork: .monochrome),
        ConcertItem(id: "toadies", title: "Toadies", venue: "Pappy & Harriet’s", schedule: "Tue, Oct 6 · 7 PM", month: "Oct", day: 6, symbol: "person.3.fill", artwork: .midnight),
        ConcertItem(id: "dan", title: "Dan Mangan", venue: "Oscar’s", schedule: "Fri, Oct 9 · 8 PM", month: "Oct", day: 9, symbol: "music.mic", artwork: .ocean)
    ]

    static let replay = [
        MusicItem(id: "september", title: "Your September Replay is here.", subtitle: "Replay the artists, songs, and albums that defined your month.", eyebrow: "Replay Monthly", symbol: "arrow.counterclockwise", artwork: .sunset),
        MusicItem(id: "all-time", title: "Replay All Time", subtitle: "The National, Death Cab for Cutie, Of Monsters and Men, and more", eyebrow: "Replay", symbol: "infinity", artwork: .ocean)
    ]

    static let newHeroItems = [
        MusicItem(id: "alt-ctrl", title: "ALT\nCTRL", subtitle: "CHVRCHES gives a nursery rhyme a powerful update with “Roses.”", eyebrow: "Updated Playlist", symbol: "waveform", artwork: .monochrome),
        MusicItem(id: "new-alt", title: "NEW\nMUSIC", subtitle: "The songs defining this week.", eyebrow: "New Music Daily", symbol: "music.note", artwork: .rose),
        MusicItem(id: "k-pop", title: "KPOP WORLD", subtitle: "Your go-to destination for all things K-pop.", eyebrow: "Updated Playlist", symbol: "music.note", artwork: .amber)
    ]

    static let bestNewSongs = [
        MusicItem(id: "to-whom", title: "To Whom It May Concern", subtitle: "A Perfect Circle", eyebrow: "", symbol: "bird.fill", artwork: .sepia),
        MusicItem(id: "silencio", title: "Silencio", subtitle: "U2", eyebrow: "", symbol: "building.2.fill", artwork: .ocean),
        MusicItem(id: "sky-hill", title: "Sky and Hill", subtitle: "The Church", eyebrow: "", symbol: "sun.haze.fill", artwork: .rose),
        MusicItem(id: "summer-clothes", title: "Summer Clothes", subtitle: "Michael Kiwanuka", eyebrow: "", symbol: "camera.macro", artwork: .violet),
        MusicItem(id: "the-dead-dance", title: "The Dead Dance", subtitle: "Lady Gaga", eyebrow: "", symbol: "person.crop.square.fill", artwork: .rose),
        MusicItem(id: "whole-wide-world", title: "Whole Wide World", subtitle: "The Rolling Stones", eyebrow: "", symbol: "mouth.fill", artwork: .green),
        MusicItem(id: "sugar-on-my-tongue", title: "Sugar on My Tongue", subtitle: "Tyler, The Creator", eyebrow: "", symbol: "paintpalette.fill", artwork: .amber),
        MusicItem(id: "stay-in-your-lane", title: "Stay in Your Lane", subtitle: "Tame Impala", eyebrow: "", symbol: "sparkles", artwork: .ocean),
        MusicItem(id: "silencio", title: "Silencio", subtitle: "U2", eyebrow: "", symbol: "building.2.fill", artwork: .ocean),
        MusicItem(id: "sky-hill", title: "Sky and Hill", subtitle: "The Church", eyebrow: "", symbol: "sun.haze.fill", artwork: .rose),
        MusicItem(id: "summer-clothes", title: "Summer Clothes", subtitle: "Michael Kiwanuka", eyebrow: "", symbol: "camera.macro", artwork: .violet)
    ]

    static let newThisWeek = [
        MusicItem(id: "bleeding", title: "We Were Bleeding…", subtitle: "From First to Last", eyebrow: "", symbol: "waveform.path.ecg", artwork: .rose),
        MusicItem(id: "rubber-soul", title: "Rubber Soul (Super Deluxe)", subtitle: "The Beatles", eyebrow: "", symbol: "leaf.fill", artwork: .forest),
        MusicItem(id: "post-self", title: "Post Self", subtitle: "The Fall", eyebrow: "", symbol: "text.below.photo", artwork: .monochrome)
    ]

    static let recentReleases = [
        MusicItem(id: "ride-lonesome", title: "Ride Lonesome", subtitle: "Beck", eyebrow: "", symbol: "door.left.hand.open", artwork: .amber),
        MusicItem(id: "better-days", title: "Better Days (Deluxe)", subtitle: "Yellowcard", eyebrow: "", symbol: "pianokeys", artwork: .ocean),
        MusicItem(id: "live-album", title: "Live at the Theatre", subtitle: "The Church", eyebrow: "", symbol: "person.fill", artwork: .violet)
    ]

    static let interviews = [
        MusicItem(id: "charli-interview", title: "Charli xcx: The Zane Lowe Interview", subtitle: "Charli xcx & Zane Lowe", eyebrow: "", symbol: "mic.fill", artwork: .monochrome),
        MusicItem(id: "andrew-interview", title: "Andrew Watt: The Interview", subtitle: "Andrew Watt & Zane Lowe", eyebrow: "", symbol: "person.2.fill", artwork: .ocean),
        MusicItem(id: "e40-interview", title: "E-40: The Interview", subtitle: "E-40 & Zane Lowe", eyebrow: "", symbol: "quote.bubble.fill", artwork: .rose)
    ]

    static let musicVideos = [
        MusicItem(id: "silencio-video", title: "Silencio", subtitle: "U2", eyebrow: "", symbol: "play.rectangle.fill", artwork: .rose),
        MusicItem(id: "run-away", title: "Run Away", subtitle: "Beck", eyebrow: "", symbol: "play.rectangle.fill", artwork: .forest),
        MusicItem(id: "tongue", title: "Tongue Tied", subtitle: "Fontaines D.C.", eyebrow: "", symbol: "play.rectangle.fill", artwork: .ocean)
    ]

    static let comingSoon = [
        MusicItem(id: "dopamine", title: "Dopamine Chamber", subtitle: "Fontaines D.C.", eyebrow: "", symbol: "waveform", artwork: .pink),
        MusicItem(id: "carnaval", title: "Carnaval De Luz", subtitle: "U2", eyebrow: "", symbol: "figure.walk", artwork: .ocean),
        MusicItem(id: "origin", title: "Origin", subtitle: "Tom Petty", eyebrow: "", symbol: "line.diagonal", artwork: .amber)
    ]

    static let recentlyAdded = [
        MusicItem(id: "library-dopamine", title: "Dopamine Chamber", subtitle: "Fontaines D.C.", eyebrow: "", symbol: "waveform", artwork: .pink),
        MusicItem(id: "library-smile", title: "Put A Smile On For Me", subtitle: "Keo", eyebrow: "", symbol: "person.crop.square", artwork: .amber),
        MusicItem(id: "library-icky-thump", title: "Icky Thump", subtitle: "The White Stripes", eyebrow: "", symbol: "guitars.fill", artwork: .monochrome),
        MusicItem(id: "library-vast", title: "Visual Audio Sensory Theater", subtitle: "VAST", eyebrow: "", symbol: "triangle.fill", artwork: .sunset),
        MusicItem(id: "library-music-for-people", title: "Music for People", subtitle: "VAST", eyebrow: "", symbol: "camera.macro", artwork: .midnight),
        MusicItem(id: "library-collective-soul", title: "Hints, Allegations & Things Left Unsaid", subtitle: "Collective Soul", eyebrow: "", symbol: "quote.bubble.fill", artwork: .rose),
        MusicItem(id: "library-dirt", title: "Dirt (Remastered)", subtitle: "Alice In Chains", eyebrow: "", symbol: "mountain.2.fill", artwork: .sunset),
        MusicItem(id: "library-ukulele", title: "Ukulele Songs", subtitle: "Eddie Vedder", eyebrow: "", symbol: "person.fill", artwork: .forest),
        MusicItem(id: "library-no-one-sings", title: "No One Sings Like You Anymore", subtitle: "Chris Cornell", eyebrow: "", symbol: "square.grid.3x3.fill", artwork: .rose),
        MusicItem(id: "library-above", title: "Above (Deluxe Edition)", subtitle: "Mad Season", eyebrow: "", symbol: "person.2.fill", artwork: .monochrome)
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
