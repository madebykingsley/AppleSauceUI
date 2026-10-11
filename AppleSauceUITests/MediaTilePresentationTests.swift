import Testing
@testable import AppleSauceUI

struct MediaTilePresentationTests {
    @Test func standardAccessibilityUsesVisibleHierarchy() {
        let presentation = MediaTilePresentation(
            title: "Example Show",
            secondaryText: "Documentary",
            tertiaryText: "Updated Weekly",
            badge: "E",
            badgeAccessibilityLabel: "Explicit"
        )

        #expect(presentation.accessibilityLabel == "Example Show, Documentary, Updated Weekly, Explicit")
    }

    @Test func rankedAccessibilityIncludesRankBeforeContent() {
        let presentation = MediaTilePresentation(
            title: "Example Album",
            secondaryText: "Example Artist",
            hierarchy: .ranked(3)
        )

        #expect(presentation.accessibilityLabel == "Rank 3, Example Album, Example Artist")
    }
}
