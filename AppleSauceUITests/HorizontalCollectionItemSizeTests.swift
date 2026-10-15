import SwiftUI
import Testing
@testable import AppleSauceUI

struct HorizontalCollectionItemSizeTests {
    @Test func iPhoneStandardWidthsPreserveDemonstratedCollectionTiers() {
        #expect(HorizontalCollectionItemSize.compact.width(in: .iPhoneStandard) == 161)
        #expect(HorizontalCollectionItemSize.standard.width(in: .iPhoneStandard) == 249)
        #expect(HorizontalCollectionItemSize.wide.width(in: .iPhoneStandard) == 334)
    }
}
