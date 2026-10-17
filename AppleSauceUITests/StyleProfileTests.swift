import SwiftUI
import Testing
@testable import AppleSauceUI

struct StyleProfileTests {
    @Test func densityKeepsLegacyDefaultsAndChangesRhythmMonotonically() {
        #expect(InterfaceDensity.standard.metrics.itemSpacing == 12)
        #expect(InterfaceDensity.standard.metrics.contentMargin == 20)
        #expect(InterfaceDensity.standard.metrics.collectionRowSpacing == 20)
        #expect(InterfaceDensity.standard.metrics.contentPadding == 12)
        #expect(InterfaceDensity.standard.metrics.prominentContentPadding == 16)
        #expect(InterfaceDensity.standard.metrics.metadataActionSpacing == 16)
        #expect(InterfaceDensity.compact.metrics.itemSpacing < InterfaceDensity.standard.metrics.itemSpacing)
        #expect(InterfaceDensity.standard.metrics.itemSpacing < InterfaceDensity.spacious.metrics.itemSpacing)
        #expect(InterfaceDensity.compact.metrics.contentMargin < InterfaceDensity.standard.metrics.contentMargin)
        #expect(InterfaceDensity.standard.metrics.contentMargin < InterfaceDensity.spacious.metrics.contentMargin)
        #expect(InterfaceDensity.compact.metrics.collectionRowSpacing < InterfaceDensity.standard.metrics.collectionRowSpacing)
        #expect(InterfaceDensity.standard.metrics.collectionRowSpacing < InterfaceDensity.spacious.metrics.collectionRowSpacing)
        #expect(InterfaceDensity.compact.metrics.contentPadding < InterfaceDensity.standard.metrics.contentPadding)
        #expect(InterfaceDensity.standard.metrics.contentPadding < InterfaceDensity.spacious.metrics.contentPadding)
        #expect(InterfaceDensity.compact.metrics.prominentContentPadding < InterfaceDensity.standard.metrics.prominentContentPadding)
        #expect(InterfaceDensity.standard.metrics.prominentContentPadding < InterfaceDensity.spacious.metrics.prominentContentPadding)
        #expect(InterfaceDensity.compact.metrics.metadataActionSpacing < InterfaceDensity.standard.metrics.metadataActionSpacing)
        #expect(InterfaceDensity.standard.metrics.metadataActionSpacing < InterfaceDensity.spacious.metrics.metadataActionSpacing)
    }

    @Test func profilesExpressDistinctShapeAndColorSchemeStrategies() {
        #expect(StyleProfile.editorial.shapes.artworkCornerRadius < StyleProfile.neutral.shapes.artworkCornerRadius)
        #expect(StyleProfile.neutral.shapes.artworkCornerRadius < StyleProfile.entertainment.shapes.artworkCornerRadius)
        #expect(StyleProfile.editorial.preferredColorScheme == nil)
        #expect(StyleProfile.neutral.preferredColorScheme == nil)
        #expect(StyleProfile.entertainment.preferredColorScheme == .dark)
    }

    @Test func profilesResolveSemanticElevation() {
        for profile in StyleProfile.allCases {
            let effects = profile.effects

            #expect(effects.shadow(for: .none).radius == 0)
            #expect(effects.shadow(for: .prominent).radius >= effects.shadow(for: .standard).radius)
        }

        #expect(StyleProfile.editorial.effects.shadow(for: .prominent).radius < StyleProfile.neutral.effects.shadow(for: .prominent).radius)
        #expect(StyleProfile.neutral.effects.shadow(for: .prominent).radius < StyleProfile.entertainment.effects.shadow(for: .prominent).radius)
    }
}
