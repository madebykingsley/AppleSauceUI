import SwiftUI
import Testing
@testable import AppleSauceUI

struct ElevatedTileTests {
    @Test func defaultsToProminentElevation() {
        let tile = ElevatedTile {
            Text("Destination")
        }

        #expect(tile.elevation == .prominent)
    }

    @Test func retainsExplicitElevation() {
        let tile = ElevatedTile(elevation: .subtle) {
            Text("Destination")
        } footer: {
            Text("Nearby")
        }

        #expect(tile.elevation == .subtle)
    }
}
