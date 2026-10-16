import SwiftUI
import Testing
@testable import AppleSauceUI

struct BrowseCategoryCardTests {
    @Test func defaultsToLandscapeLayout() {
        let card = BrowseCategoryCard(
            title: "Music",
            systemImage: "music.note",
            background: Color.pink
        )

        #expect(card.layout == .landscape)
        #expect(card.systemImage == "music.note")
    }

    @Test func retainsPortraitLayout() {
        let card = BrowseCategoryCard(
            title: "Television",
            systemImage: "play.tv.fill",
            background: Color.blue,
            layout: .portrait
        )

        #expect(card.layout == .portrait)
        #expect(card.layout.aspectRatio < 1)
    }
}
