import SwiftUI
import Testing
@testable import AppleSauceUI

struct EpisodeCardTests {
    @Test func acceptsSemanticEpisodeContent() {
        let card = EpisodeCard(
            date: "Today",
            showTitle: "Daily Stories",
            episodeTitle: "A New Episode",
            summary: "Episode summary",
            duration: "24m",
            mediaBadge: "Video",
            mediaBadgeAccessibilityLabel: "video",
            background: Color.blue
        ) {
            Color.clear
        }

        #expect(card.date == "Today")
        #expect(card.showTitle == "Daily Stories")
        #expect(card.episodeTitle == "A New Episode")
        #expect(card.summary == "Episode summary")
        #expect(card.duration == "24m")
        #expect(card.mediaBadge == "Video")
        #expect(card.mediaBadgeAccessibilityLabel == "video")
    }

    @Test func optionalContentDefaultsToAbsent() {
        let card = EpisodeCard(
            date: "Yesterday",
            showTitle: "The Show",
            episodeTitle: "The Episode",
            duration: "42m",
            background: Color.indigo
        ) {
            Color.clear
        }

        #expect(card.summary == nil)
        #expect(card.mediaBadge == nil)
        #expect(card.mediaBadgeSystemImage == "video.fill")
    }
}
