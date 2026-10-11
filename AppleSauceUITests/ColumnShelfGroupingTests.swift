import Testing
@testable import AppleSauceUI

struct ColumnShelfGroupingTests {
    private struct Item: Identifiable, Equatable {
        let id: Int
    }

    @Test func emptyInputProducesNoColumns() {
        let columns = ColumnShelfGrouping.columns(from: [Item](), rows: 3)
        #expect(columns.isEmpty)
    }

    @Test func exactGroupsHaveRequestedRowCount() {
        let columns = ColumnShelfGrouping.columns(from: items(1...6), rows: 3)
        #expect(columns.map(\.elements.count) == [3, 3])
        #expect(columns.map(\.id) == [1, 4])
    }

    @Test func partialGroupIsRetained() {
        let columns = ColumnShelfGrouping.columns(from: items(1...5), rows: 2)
        #expect(columns.map(\.elements.count) == [2, 2, 1])
        #expect(columns.last?.elements.map(\.id) == [5])
    }

    @Test func groupingPreservesInputOrdering() {
        let input = [Item(id: 8), Item(id: 3), Item(id: 5), Item(id: 1)]
        let flattened = ColumnShelfGrouping.columns(from: input, rows: 3).flatMap(\.elements)
        #expect(flattened.map(\.id) == input.map(\.id))
    }

    @Test func columnIdentityFollowsFirstContainedItemWhenDataChanges() {
        let original = ColumnShelfGrouping.columns(from: items(1...4), rows: 2)
        let appended = ColumnShelfGrouping.columns(from: items(1...5), rows: 2)
        let prepended = ColumnShelfGrouping.columns(from: [Item(id: 0)] + items(1...4), rows: 2)

        #expect(original.map(\.id) == [1, 3])
        #expect(appended.prefix(2).map(\.id) == original.map(\.id))
        #expect(prepended.map(\.id) == [0, 2, 4])
    }

    private func items(_ range: ClosedRange<Int>) -> [Item] {
        range.map(Item.init(id:))
    }
}
