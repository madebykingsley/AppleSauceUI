import SwiftUI
import Testing
@testable import AppleSauceUI

struct EpisodeRowTests {
    @Test func accessibilityMetadataIncludesBadgeMeaning() {
        let row = EpisodeRow(
            dateOrStatus: "Today",
            title: "A New Episode",
            supportingMetadata: "From Example Show",
            duration: "24m",
            mediaBadge: "Video",
            mediaBadgeAccessibilityLabel: "video episode",
            artworkSize: 90,
            artworkSpacing: 11
        ) {
            Color.clear
        }

        #expect(row.accessibilityMetadataLabel == "Today, A New Episode, From Example Show, 24m, video episode")
    }

    @Test func playbackDurationIsNotDuplicatedInMetadata() {
        let row = EpisodeRow(
            dateOrStatus: "Yesterday",
            title: "The Episode",
            duration: "42m",
            artworkSize: 90,
            artworkSpacing: 11,
            playAction: {}
        ) {
            Color.clear
        }

        #expect(row.accessibilityMetadataLabel == "Yesterday, The Episode")
    }
}
