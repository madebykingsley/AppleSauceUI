# AppleSauceUI Library

The Library owns reusable presentation and behavior. `Examples` owns product models, fixtures, navigation, state, reference geometry, and mapping into the neutral APIs below. Library code never depends on `Examples`.

## Architecture

| Layer | Responsibility |
|---|---|
| Foundations | Shared visual and behavioral primitives |
| Elements | Independent content presentations and controls |
| Patterns | Collection layout, scrolling, margins, and interaction |
| Recipes | Complete screenshot-driven example screens |
| Style Profiles | Coherent typography, color, shape, imagery, effects, motion, and chrome decisions |
| Density | Independent compact, standard, or spacious layout rhythm |
| Platform adaptation | Native conventions applied after pattern, profile, and density selection |

See `Docs/Architecture/Ownership.md` for the decision boundaries agents and contributors should preserve between these layers.

## Style Profiles and density

Apply `.styleProfile(.editorial)`, `.styleProfile(.entertainment)`, or `.styleProfile(.neutral)` to establish a coherent visual language for a subtree. Elements ask the environment for semantic concepts such as section-title typography, primary text, artwork shape, imagery treatment, and effects. A Style Profile never selects content, information architecture, pattern variants, or platform behavior. Hosts may set `honorsPreferredColorScheme: false` when multiple profiles must be compared in one presentation.

Apply `.interfaceDensity(.compact)`, `.standard`, or `.spacious` separately. Density changes broad collection rhythm—section spacing, item spacing, content margins, and metadata spacing—without encoding brand or visual personality. Existing screens inherit Neutral + Standard, whose values preserve the previous defaults.

The proof covers the `MediaShelf` and `MediaGrid` Patterns plus the content-rich `MediaCard` Element. Collection patterns consume density; `MediaCard` consumes density for internal rhythm; and Elements request Style Profile semantics without branching on profile identity. Other components remain unchanged until a demonstrated use justifies adopting the same foundation.

Profile values currently remain native SwiftUI values because the proof has no external token exchange requirement. If customizable tokens cross tool or platform boundaries later, expose only meaningful decisions in Design Tokens Community Group format and map them into these semantic Swift types; do not serialize system colors, text styles, or materials merely to replace native APIs.

## Lockups

Use `SquareLockup` for albums, shows, square events, rankings, and library items. Its direct inputs cover title, optional subtitle and metadata, optional badge accessibility, and the demonstrated standard, ranked, and library styles.

Use `PosterLockup` for portrait, full-bleed featured artwork. The caller supplies its reference-specific height; the component does not provide a landscape mode or arbitrary overlay slots.

Use `HorizontalLockup` for leading artwork, semantic metadata, and an optional independent accessory. It moves the accessory below the main content at accessibility Dynamic Type sizes.

`CircleLockup` is planned only after a concrete reference establishes its API. A separate `TrackLockup` is not currently needed.

Use `MediaCard` for landscape artwork and its semantic eyebrow, title, subtitle, metadata, and badge hierarchy. Select `.standard` for distinct artwork and text regions or `.overlay` for metadata layered over artwork; the Style Profile never selects this structural layout. Specialized Recipes may use the lower-level metadata and independent-actions slots when the semantic initializer is insufficient.

Use `EditorialHero` when an editorial eyebrow and heading sit outside and above landscape artwork. Bespoke branded editorial artwork, promotions, and simple discovery buttons remain recipe-owned compositions rather than separate Library card types.

`EpisodeRow` gives supplied artwork a fixed square viewport based on its presentation and clips artwork to that viewport. Row height remains content-driven so metadata and controls can adapt at accessibility Dynamic Type sizes.

## Collection patterns

- `MediaShelf` owns titled horizontal collection layout, scrolling policy, item spacing, and content margins. Its default spacing and margins resolve from `InterfaceDensity`; explicit recipe geometry still takes precedence.
- `RankedShelf` supplies stable, one-based ranks while delegating presentation to its item closure.
- `MediaGrid` owns optional heading, columns, gaps, and horizontal margins. Its default gaps and margins resolve from `InterfaceDensity`; explicit recipe geometry still takes precedence.
- Column shelves retain column-major grouping and stable identity for demonstrated multi-row episode and track collections.
- `ShelfSection`, `CategoryList`, and `LinkSection` remain semantic compositions for their demonstrated uses.

Brand tint is applied at the recipe root and inherited by Library controls. Actions are caller-provided, accessory controls remain independent, and recipe-specific measurements do not become global component defaults.

## Platform scope

These APIs are demonstrated on iOS and iPadOS by the Music and Podcasts recipes. Other Apple platforms are not yet documented.
