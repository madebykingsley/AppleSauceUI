import SwiftUI
import Testing
@testable import AppleSauceUI

struct SquareLockupTests {
    @Test func standardAccessibilityLabelIncludesAvailableMetadata() {
        let lockup = SquareLockup(
            title: "Album",
            subtitle: "Artist",
            metadata: "2026",
            badge: "E",
            badgeAccessibilityLabel: "Explicit"
        ) {
            Color.clear
        }

        #expect(lockup.accessibilityLabel == "Album, Artist, 2026, Explicit")
    }

    @Test func rankedAccessibilityLabelStartsWithRank() {
        let lockup = SquareLockup(title: "Show", subtitle: "Publisher", style: .ranked(2)) {
            Color.clear
        }

        #expect(lockup.accessibilityLabel == "Rank 2, Show, Publisher")
    }
}
