import SwiftUI
import Testing
@testable import AppleSauceUI

struct MediaCardTests {
    @Test func semanticCardDefaultsToStandardLayout() {
        let card = MediaCard(title: "Title") {
            Color.clear
        }

        #expect(card.layout == .standard)
        #expect(card.elevation == .standard)
    }

    @Test func overlayLayoutRemainsAnExplicitStructuralChoice() {
        let card = MediaCard(layout: .overlay, title: "Title") {
            Color.clear
        }

        #expect(card.layout == .overlay)
    }

    @Test func explicitElevationIsRetained() {
        let card = MediaCard(elevation: .none, title: "Live Event") {
            Color.clear
        }

        #expect(card.elevation == .none)
    }
}
