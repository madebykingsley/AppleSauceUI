import SwiftUI
import Testing
@testable import AppleSauceUI

struct HorizontalLockupTests {
    @Test func squareArtworkConvenienceCreatesEqualDimensions() {
        let lockup = HorizontalLockup(artworkSize: 48, spacing: 11) {
            Color.clear
        } content: {
            Text("Track")
        }

        #expect(lockup.artworkSize == CGSize(width: 48, height: 48))
        #expect(lockup.spacing == 11)
        #expect(lockup.alignment == .center)
    }

    @Test func rectangularArtworkAndIndependentAlignmentsAreRetained() {
        let lockup = HorizontalLockup(
            artworkSize: CGSize(width: 120, height: 80),
            spacing: 16,
            alignment: .top,
            accessoryAlignment: .bottom
        ) {
            Color.clear
        } content: {
            Text("Editorial content")
        } accessory: {
            Button("More", action: {})
        }

        #expect(lockup.artworkSize == CGSize(width: 120, height: 80))
        #expect(lockup.spacing == 16)
        #expect(lockup.alignment == .top)
        #expect(lockup.accessoryAlignment == .bottom)
    }
}
