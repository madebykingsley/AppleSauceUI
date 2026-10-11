import SwiftUI
import Testing
@testable import AppleSauceUI

struct StyleProfileTests {
    @Test func densityKeepsLegacyDefaultsAndChangesRhythmMonotonically() {
        #expect(InterfaceDensity.standard.metrics.itemSpacing == 12)
        #expect(InterfaceDensity.standard.metrics.contentMargin == 20)
        #expect(InterfaceDensity.standard.metrics.collectionRowSpacing == 20)
        #expect(InterfaceDensity.standard.metrics.contentPadding == 12)
        #expect(InterfaceDensity.compact.metrics.itemSpacing < InterfaceDensity.standard.metrics.itemSpacing)
        #expect(InterfaceDensity.standard.metrics.itemSpacing < InterfaceDensity.spacious.metrics.itemSpacing)
        #expect(InterfaceDensity.compact.metrics.contentMargin < InterfaceDensity.standard.metrics.contentMargin)
        #expect(InterfaceDensity.standard.metrics.contentMargin < InterfaceDensity.spacious.metrics.contentMargin)
        #expect(InterfaceDensity.compact.metrics.collectionRowSpacing < InterfaceDensity.standard.metrics.collectionRowSpacing)
        #expect(InterfaceDensity.standard.metrics.collectionRowSpacing < InterfaceDensity.spacious.metrics.collectionRowSpacing)
        #expect(InterfaceDensity.compact.metrics.contentPadding < InterfaceDensity.standard.metrics.contentPadding)
        #expect(InterfaceDensity.standard.metrics.contentPadding < InterfaceDensity.spacious.metrics.contentPadding)
    }

    @Test func profilesExpressDistinctShapeAndColorSchemeStrategies() {
        #expect(StyleProfile.editorial.shapes.artworkCornerRadius < StyleProfile.neutral.shapes.artworkCornerRadius)
        #expect(StyleProfile.neutral.shapes.artworkCornerRadius < StyleProfile.entertainment.shapes.artworkCornerRadius)
        #expect(StyleProfile.editorial.preferredColorScheme == nil)
        #expect(StyleProfile.neutral.preferredColorScheme == nil)
        #expect(StyleProfile.entertainment.preferredColorScheme == .dark)
    }
}
