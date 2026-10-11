# AppleSauceUI Library

The Library owns reusable presentation and behavior. `Examples` owns product models, fixtures, navigation, state, reference geometry, and mapping into the neutral APIs below. Library code never depends on `Examples`.

## Architecture

| Layer | Responsibility |
|---|---|
| Foundations | Shared visual and behavioral primitives |
| Elements | Independent content presentations and controls |
| Patterns | Collection layout, scrolling, margins, and interaction |
| Recipes | Complete screenshot-driven example screens |

## Lockups

Use `SquareLockup` for albums, shows, square events, rankings, and library items. Its direct inputs cover title, optional subtitle and metadata, optional badge accessibility, and the demonstrated standard, ranked, and library styles.

Use `PosterLockup` for portrait, full-bleed featured artwork. The caller supplies its reference-specific height; the component does not provide a landscape mode or arbitrary overlay slots.

Use `HorizontalLockup` for leading artwork, semantic metadata, and an optional independent accessory. It moves the accessory below the main content at accessibility Dynamic Type sizes.

`CircleLockup` is planned only after a concrete reference establishes its API. A separate `TrackLockup` is not currently needed.

Use `MediaCard` for landscape artwork followed by caller-composed metadata and optional independent actions. Recipes own content-specific hierarchy and map their domain fixtures directly into these slots.

Use `EditorialHero` when an editorial eyebrow and heading sit outside and above landscape artwork. Bespoke branded editorial artwork, promotions, and simple discovery buttons remain recipe-owned compositions rather than separate Library card types.

`EpisodeRow` gives supplied artwork a fixed square viewport based on its presentation and clips artwork to that viewport. Row height remains content-driven so metadata and controls can adapt at accessibility Dynamic Type sizes.

## Collection patterns

- `MediaShelf` owns titled horizontal collection layout, scrolling policy, item spacing, and content margins.
- `RankedShelf` supplies stable, one-based ranks while delegating presentation to its item closure.
- `MediaGrid` owns optional heading, columns, gaps, and horizontal margins.
- Column shelves retain column-major grouping and stable identity for demonstrated multi-row episode and track collections.
- `ShelfSection`, `CategoryList`, and `LinkSection` remain semantic compositions for their demonstrated uses.

Brand tint is applied at the recipe root and inherited by Library controls. Actions are caller-provided, accessory controls remain independent, and recipe-specific measurements do not become global component defaults.

## Platform scope

These APIs are demonstrated on iOS and iPadOS by the Music and Podcasts recipes. Other Apple platforms are not yet documented.
