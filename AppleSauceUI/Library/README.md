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

The original proof covers the `MediaShelf` and `MediaGrid` Patterns plus the content-rich `MediaCard` Element. The same semantic vocabulary is now adopted by `PosterLockup`, `EditorialHero`, `HorizontalLockup`, `EpisodeRow`, `SectionHeader`, and artwork placeholders. Collection patterns consume density; content Elements request Style Profile semantics without branching on profile identity; and explicit Element variants remain caller-selected.

`heroTitle`, `heroEyebrow`, and `heroSupporting` describe the hierarchy within a hero-level content presentation. They are intentionally broader than `PosterLockup`: use them only when content establishes the dominant hierarchy for an entire hero, not for section headings, ordinary card metadata, or component-specific sizing. Neutral preserves the established large-title hero treatment.

`prominentContentTitle` distinguishes feature-level content headings from ordinary card titles, while `itemSubtitle` provides readable secondary identity such as an artist or show name without promoting lower-priority metadata.

Profile values currently remain native SwiftUI values because the proof has no external token exchange requirement. If customizable tokens cross tool or platform boundaries later, expose only meaningful decisions in Design Tokens Community Group format and map them into these semantic Swift types; do not serialize system colors, text styles, or materials merely to replace native APIs.

## Lockups

Use `SquareLockup` for albums, shows, square events, rankings, and library items. Its direct inputs cover title, optional subtitle and metadata, optional badge accessibility, and the demonstrated standard, ranked, and library styles.

Use `PosterLockup` for portrait, full-bleed featured artwork. The caller supplies its reference-specific height and may choose a semantic elevation; the active Style Profile defines how that elevation is rendered. The component does not provide a landscape mode or arbitrary overlay slots.

Artwork containers own clipping and effects for supplied artwork so placeholders and real images receive the same treatment. `ArtworkPlaceholder` supplies placeholder visuals and inherits the semantic artwork shape when no override is provided; it is not a universal artwork container. `ArtworkThumbnail` remains placeholder-specific, so its fixed thumbnail radius is not yet a shared shape convention.

Use `HorizontalLockup` for leading artwork, semantic metadata, and an optional independent accessory. It intentionally moves the accessory below the main content at accessibility Dynamic Type sizes. `ViewThatFits` was considered, but geometry-only selection could retain the compact arrangement at an accessibility size; the explicit Dynamic Type policy better preserves the component's demonstrated behavior.

Use `VideoLockup` for lightweight landscape video artwork with a title and optional subtitle or metadata inside a shelf or grid. The caller supplies artwork and any reference-specific aspect ratio. Use `MediaCard` instead when the item needs a richer surface, overlay, or independent controls. Music video and interview shelves currently demonstrate `VideoLockup` on iOS and iPadOS.

`CircleLockup` is planned only after a concrete reference establishes its API. A separate `TrackLockup` is not currently needed.

Use `MediaCard` for landscape artwork and its semantic eyebrow, title, subtitle, metadata, and badge hierarchy. Select `.standard` for distinct artwork and text regions or `.overlay` for metadata layered over artwork; the Style Profile never selects this structural layout. Specialized example presentations may use the lower-level metadata and independent-actions slots when the semantic initializer is insufficient.

Use `EditorialHero` when an editorial eyebrow and heading sit outside and above landscape artwork. Bespoke branded editorial artwork, promotions, and simple discovery buttons remain example-owned compositions rather than separate Library card types.

`EpisodeRow` gives supplied artwork a fixed square viewport based on its presentation and clips artwork to that viewport. Row height remains content-driven so metadata and controls can adapt at accessibility Dynamic Type sizes.

## Collection patterns

- `MediaShelf` owns titled horizontal collection layout, scrolling policy, item spacing, and content margins. Its default spacing and margins resolve from `InterfaceDensity`; explicit recipe geometry still takes precedence.
- `RankedShelf` supplies stable, one-based ranks while delegating presentation to its item closure.
- `MediaGrid` owns optional heading, columns, gaps, and horizontal margins. Its default gaps and margins resolve from `InterfaceDensity`; explicit recipe geometry still takes precedence.
- `ColumnMediaShelf` uses native `LazyHGrid` column-major placement for demonstrated multi-row episode and track collections.
- Native `Section`, `NavigationLink`, `Label`, and navigation toolbars own standard structure and interaction; the Library does not wrap them.

Brand tint is applied at the example root and inherited by Library controls. Actions are caller-provided, accessory controls remain independent, and example-specific measurements do not become global component defaults.

## Platform scope

These APIs are demonstrated on iOS and iPadOS by the Music and Podcasts examples. Other Apple platforms are not yet documented.
