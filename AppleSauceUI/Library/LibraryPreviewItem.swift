#if DEBUG
struct LibraryPreviewItem: Identifiable {
    let id: Int
    let title: String

    static let samples = [
        LibraryPreviewItem(id: 1, title: "First"),
        LibraryPreviewItem(id: 2, title: "Second"),
        LibraryPreviewItem(id: 3, title: "Third"),
        LibraryPreviewItem(id: 4, title: "Fourth"),
        LibraryPreviewItem(id: 5, title: "Fifth")
    ]
}
#endif
