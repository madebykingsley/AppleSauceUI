import SwiftUI
import Testing
@testable import AppleSauceUI

struct VideoLockupTests {
    @Test func accessibilityLabelIncludesAvailableMetadata() {
        let lockup = VideoLockup(title: "Episode", subtitle: "Series", metadata: "24 min") {
            Color.clear
        }

        #expect(lockup.accessibilityLabel == "Episode, Series, 24 min")
    }
}
