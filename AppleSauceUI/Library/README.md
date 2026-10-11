# AppleSauceUI Library

The Library owns reusable Apple-platform presentation and behavior. `Examples` owns product models, fixtures, artwork data, navigation, state, and mappings into the neutral inputs below. Library code must never import or reference an example domain.

## Preferred APIs

| API | Owns | Caller supplies |
|---|---|---|
| `MediaTile` | Artwork placement/aspect ratio, primary and secondary text hierarchy, ranks, badges, line limits, accessibility composition | `MediaTilePresentation` and artwork |
| `ArtworkPlaceholder`, `ArtworkThumbnail` | Standard generated-artwork geometry | Symbol and background style |
| `EpisodeRow` | Episode-specific date/show/duration hierarchy, responsive progress presentation, and independent playback/skip/overflow controls | Episode text, optional badge/progress, artwork, actions |
| `PlaybackButton` | Standard play control appearance and semantics | Label, accessibility label, action |
| `MediaCard` | Rounded high-contrast card container | Background, artwork, details |
| `EpisodeCard`, `TrailerCard` | Distinct card hierarchy and independent controls | Editorial text, artwork, background, actions |
| `FeatureCard`, `EditorialCard` | Featured/editorial hierarchy over content-driven backgrounds | Copy, background, height |
| `PromotionalCard`, `DiscoveryCard` | Reusable promotional and discovery treatments | Copy, symbol, background, action |
| `EventTile`, `CalendarDateBadge` | Event artwork/metadata hierarchy and date placement | Event fields and artwork |
| `AccountButton` | Circular account hit target and accessibility label | Avatar content and action |
| `SectionHeader`, `SectionHeaderButton` | Shared static and explicitly actionable section-header hierarchy, including optional subtitle, eyebrow, leading artwork, and title accessory | Text, optional leading content/accessory, and an explicit action for the button wrapper |
| `ShelfSection`, `MediaShelf`, `ColumnMediaShelf` | Header-to-content spacing, margins, collection sizing, scrolling policy | Identifiable items, widths/rows, item views |
| `MediaGridSection`, `ArtworkGrid` | Prominent grid heading, columns, gaps, margins | Identifiable items and item views |
| `HorizontalShelf`, `ColumnShelf` | Low-level scrolling and column-major grouping | Identifiable items and content |
| `CategoryList`, `CategoryRowLabel`, `LinkSection` | Repeated actions, separators, row geometry, card/plain link styles | Items, labels, actions |
| `ScreenTitle`, `EditorialHero`, `MediaRow` | Screen heading, editorial hero, and low-level responsive row composition | Narrow text/content inputs |

## Media tiles

The normal tile path is semantic. Callers do not restyle `Text`:

```swift
MediaTile(
    presentation: MediaTilePresentation(
        title: album.title,
        secondaryText: album.artist
    )
) {
    AlbumArtwork(album: album)
}
.tint(.pink)

MediaTile(
    presentation: MediaTilePresentation(
        title: show.title,
        secondaryText: show.publisher,
        badge: "E",
        badgeAccessibilityLabel: "Explicit",
        hierarchy: .ranked(2)
    )
) {
    ShowArtwork(show: show)
}
.tint(.purple)
```

`MediaTile` always applies `.primary` to its title and `.secondary` to supporting information, so a parent metadata style cannot accidentally demote the title. `.standard`, `.ranked(Int)`, and `.library` express demonstrated hierarchy differences without app-specific switches.

`ArtworkTile` remains available as a low-level custom-content API when a genuinely different metadata composition is required. Prefer `MediaTile` for album, show, library, and ranked presentations.

## Sections and collections

Use `MediaShelf` for ordinary horizontal shelves and `ColumnMediaShelf` for multi-row horizontal shelves. Both compose the standard header spacing and margin policy:

```swift
MediaShelf(title: "Recently Played", items: albums, itemWidth: 161) { album in
    MediaTile(presentation: album.presentation) {
        AlbumArtwork(album: album)
    }
}

ColumnMediaShelf(title: "New Episodes", items: episodes, rows: 3, columnWidth: 334) { episode in
    EpisodeRow(/* mapped presentation inputs and explicit actions */)
}
```

Use `ShelfSection` when the content is not a collection, `MediaGridSection` for titled grids, and `SectionHeader` or `SectionHeaderButton` plus `HorizontalShelf` for reference-item shelves. Screens own spacing between sections; these patterns own header-to-content spacing and horizontal content margins.

## Interaction and styling ownership

- Brand tint is supplied once at the example root and inherited by Library controls.
- Artwork backgrounds and intentionally high-contrast controls remain explicit content treatments, not brand tint.
- Actions are always caller-provided. Library does not add playback backends or destinations.
- Accessory controls remain independent buttons; do not nest them inside a parent button.
- `ColumnShelf` groups items column-major and identifies each column by its first item. Appends preserve existing column identity; insertion, deletion, or reordering may regroup columns.
- `CategoryList` uses a lazy stack because it is designed for composition inside a larger vertical `ScrollView`. Prefer `List` for standalone destinations.

## Platform scope

These APIs are demonstrated on iOS and iPadOS with the Music and Podcasts examples. macOS, watchOS, tvOS, and visionOS behavior is not yet documented.
