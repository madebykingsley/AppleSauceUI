import SwiftUI
import Testing
@testable import AppleSauceUI

struct MediaGridTests {
    @Test func titleDefaultsToAbsent() {
        let grid = MediaGrid(items: LibraryPreviewItem.samples) { item in
            Text(item.title)
        }

        #expect(grid.title == nil)
    }

    @Test func retainsExplicitTitle() {
        let grid = MediaGrid(title: "Featured", items: LibraryPreviewItem.samples) { item in
            Text(item.title)
        }

        #expect(grid.title != nil)
    }
}
