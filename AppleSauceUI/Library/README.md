# AppleSauceUI Library

The Library owns reusable presentation and behavior. `Examples` owns product models, fixtures, navigation, state, reference geometry, and mapping into the neutral APIs below. Library code never depends on `Examples`.

## Architecture

| Layer | Responsibility |
|---|---|
| Foundations | Shared visual and behavioral primitives |
| Elements | Independent content presentations and controls |
| Patterns | Collection layout, scrolling, margins, and interaction |
| Examples | Concrete screenshot-driven screens, navigation, fixtures, and domain-to-Library mapping |
| Style Profiles | Coherent typography, color, shape, imagery, effects, motion, and chrome decisions |
| Density | Independent compact, standard, or spacious layout rhythm |
| Platform adaptation | Native conventions applied after pattern, profile, and density selection |

See `Docs/Architecture/Ownership.md` for the decision boundaries agents and contributors should preserve between these layers.

## Style Profiles and density

Apply `.styleProfile(.editorial)`, `.styleProfile(.entertainment)`, or `.styleProfile(.neutral)` to establish a coherent visual language for a subtree. Elements ask the environment for semantic concepts such as section-title typography, primary text, artwork shape, imagery treatment, and effects. A Style Profile never selects content, information architecture, pattern variants, or platform behavior. Hosts may set `honorsPreferredColorScheme: false` when multiple profiles must be compared in one presentation.

Apply `.interfaceDensity(.compact)`, `.standard`, or `.spacious` separately. Density changes broad collection rhythm—section spacing, item spacing, content margins, and metadata spacing—without encoding brand or visual personality. Existing screens inherit Neutral + Standard, whose values preserve the previous defaults.

The original proof covers the `MediaShelf` and `MediaGrid` Patterns plus the content-rich `MediaCard` Element. The same semantic vocabulary is now adopted by `PosterLockup`, `EditorialHero`, `SectionHeader`, and artwork placeholders. Collection patterns consume density; content Elements request Style Profile semantics without branching on profile identity; and explicit Element variants remain caller-selected. `HorizontalLockup` deliberately remains geometry-only so its children can supply the appropriate semantic hierarchy for each category.

`heroTitle`, `heroEyebrow`, and `heroSupporting` describe the hierarchy within a hero-level content presentation. They are intentionally broader than `PosterLockup`: use them only when content establishes the dominant hierarchy for an entire hero, not for section headings, ordinary card metadata, or component-specific sizing. Neutral preserves the established large-title hero treatment.

`prominentContentTitle` distinguishes feature-level content headings from ordinary card titles, while `itemSubtitle` provides readable secondary identity such as an artist or show name without promoting lower-priority metadata.

Profile values currently remain native SwiftUI values because the proof has no external token exchange requirement. If customizable tokens cross tool or platform boundaries later, expose only meaningful decisions in Design Tokens Community Group format and map them into these semantic Swift types; do not serialize system colors, text styles, or materials merely to replace native APIs.

## Lockups

Use `SquareLockup` for albums, shows, square events, rankings, and library items. Its direct inputs cover title, optional subtitle and metadata, optional badge accessibility, and the demonstrated standard, ranked, and library styles.

Use `PosterLockup` for portrait, full-bleed featured artwork. The caller supplies its reference-specific height and may choose a semantic elevation; the active Style Profile defines how that elevation is rendered. The component does not provide a landscape mode or arbitrary overlay slots.

Artwork containers own clipping and effects for supplied artwork so placeholders and real images receive the same treatment. Standalone artwork surfaces use the Style Profile's subtle outline in every color scheme, which preserves their edge against dark or visually similar backgrounds. `ArtworkPlaceholder` supplies placeholder visuals and inherits the semantic artwork shape when no override is provided; it is not a universal artwork container. `ArtworkThumbnail` remains placeholder-specific, so its fixed thumbnail radius is not yet a shared shape convention.

Use `ArtworkImage` for bitmap artwork from an asset catalog. It accepts an optional asset name and renders an `ArtworkPlaceholder` when the resource is absent or cannot be loaded. It owns image loading and scaling only; surrounding lockups and cards continue to own shape, clipping, overlays, and elevation. Use `ArtworkPlaceholder` directly for intentionally generated playlist, station, category, and collection artwork.

Use `HorizontalLockup` for sized leading artwork, flexible caller-supplied content, and an optional independent trailing accessory. Supply a scalar size for square artwork or `CGSize` for other proportions. The lockup applies the shared artwork shape and subtle outline; the caller owns imagery content, typography, hierarchy, actions, and accessibility. Bottom controls belong inside the content builder. Artwork/content and accessory vertical alignments are independent, while row padding and separators remain container responsibilities.

Use `VideoLockup` for lightweight landscape video artwork with a title and optional subtitle or metadata inside a shelf or grid. The caller supplies artwork and any reference-specific aspect ratio. Use `MediaCard` instead when the item needs a richer surface, overlay, or independent controls. Music video and interview shelves currently demonstrate `VideoLockup` on iOS and iPadOS.

`CircleLockup` is planned only after a concrete reference establishes its API. A separate `TrackLockup` is not currently needed.

Use `MediaCard` for landscape artwork and its semantic eyebrow, title, subtitle, metadata, and badge hierarchy. Select `.standard` for distinct artwork and text regions or `.overlay` for metadata layered over artwork; the Style Profile never selects this structural layout. Specialized example presentations may use the lower-level metadata and independent-actions slots when the semantic initializer is insufficient.

Use `ElevatedTile` for compact square choices whose supplied primary content and optional footer belong on one raised surface. It owns square geometry and Style Profile/Density treatment while callers retain artwork, branding, accessibility labels, and native control semantics. Use `SquareLockup` instead when metadata belongs outside the artwork.

Use `EpisodeCard` for a playable audio or video episode whose landscape artwork, date or status, show identity, episode title, optional summary, duration, media badge, and independent play and overflow controls form one stable anatomy. It builds on `MediaCard`; use `PosterLockup` instead for portrait, full-bleed hero content and use `MediaCard` directly for non-episode cards.

Use `EditorialHero` when an editorial eyebrow and heading sit outside and above landscape artwork. Bespoke branded editorial artwork, promotions, and simple discovery buttons remain example-owned compositions rather than separate Library card types.

## Collection patterns

- `MediaShelf` owns titled horizontal collection layout, scrolling policy, item spacing, and content margins. Its default spacing and margins resolve from `InterfaceDensity`; explicit recipe geometry still takes precedence. `HorizontalCollectionItemSize` names compact, standard, and wide collection tiers, resolved for an explicit demonstrated sizing context. The current 161-, 249-, and 334-point values apply only to iPhone at Standard density and must not be treated as universal platform dimensions.
- `RankedShelf` supplies stable, one-based ranks while delegating presentation to its item closure.
- `MediaGrid` owns optional heading, columns, gaps, and horizontal margins for media, category, channel, and similar browsable collections. Its default gaps and margins resolve from `InterfaceDensity`; explicit specimen geometry still takes precedence.
- `ColumnMediaShelf` uses native `LazyHGrid` column-major placement for demonstrated multi-row episode and track collections. It and `RankedShelf` inherit content margins from `InterfaceDensity` unless the caller supplies an explicit override.
- Native `Section`, `NavigationLink`, `Label`, and navigation toolbars own standard structure and interaction; the Library does not wrap them.

Brand tint is applied at the example root and inherited by Library controls. Actions are caller-provided, accessory controls remain independent, and example-specific measurements do not become global component defaults.

## Platform scope

These APIs are demonstrated on iOS and iPadOS by the Music and Podcasts examples. Other Apple platforms are not yet documented.
