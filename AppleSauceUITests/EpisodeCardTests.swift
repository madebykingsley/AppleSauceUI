import SwiftUI
import Testing
@testable import AppleSauceUI

struct EpisodeCardTests {
    @Test func acceptsSemanticEpisodeContent() {
        let card = EpisodeCard(
            date: "Today",
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
        #expect(card.episodeTitle == "A New Episode")
        #expect(card.summary == "Episode summary")
        #expect(card.duration == "24m")
        #expect(card.mediaBadge == "Video")
        #expect(card.mediaBadgeAccessibilityLabel == "video")
        #expect(card.accessibilityMetadataLabel == "Today, A New Episode, Episode summary, video")
    }

    @Test func optionalContentDefaultsToAbsent() {
        let card = EpisodeCard(
            date: "Yesterday",
            episodeTitle: "The Episode",
            duration: "42m",
            background: Color.indigo
        ) {
            Color.clear
        }

        #expect(card.summary == nil)
        #expect(card.mediaBadge == nil)
        #expect(card.mediaBadgeSystemImage == "video.fill")
        #expect(card.accessibilityMetadataLabel == "Yesterday, The Episode")
    }

    @Test func badgeTextProvidesAccessibilityFallback() {
        let card = EpisodeCard(
            date: "Today",
            episodeTitle: "The Episode",
            duration: "18m",
            mediaBadge: "Video",
            background: Color.teal
        ) {
            Color.clear
        }

        #expect(card.accessibilityMetadataLabel == "Today, The Episode, Video")
    }
}
