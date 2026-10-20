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

## Screen-driven workflow

Use one ordered workflow for reconstruction work:

1. **Inspect:** study the reference, existing component documentation, and representative consumers.
2. **Prove with actual content:** establish hierarchy, geometry, artwork behavior, controls, and adaptation using the specimen's real fixtures and states.
3. **Generalize:** reuse, extend, or extract focused Elements and Patterns while keeping domain models, assets, and screen composition in Examples.
4. **Verify the final consumer:** render the post-generalization screen, correct layout-blocking defects, and reinspect relevant states after corrections.

Evaluate component reuse by comparing anatomy, geometry ownership, interaction, and adaptive behavior. Similar appearance alone is insufficient. Component reuse means sharing semantic presentation and behavior; asset reuse means sharing supplied artwork, symbols, colors, or other content. Reusing an asset does not require the views that display it to become one component.

Visual completion requires rendered evidence when rendering is available. Unintended overlap, clipped readable content, incorrect artwork bounds, and inaccessible or unreachable controls are blockers and require correction followed by reinspection. After those gates pass, ordinary work allows one focused comparison pass and one grouped set of cosmetic corrections, followed by reinspection. If rendering is unavailable, report the work as **visually unverified** and name the unchecked configurations; a successful build is not visual verification.

## Style Profiles and density

Apply `.styleProfile(.editorial)`, `.styleProfile(.entertainment)`, or `.styleProfile(.neutral)` to establish a coherent visual language for a subtree. Elements ask the environment for semantic concepts such as section-title typography, primary text, artwork shape, imagery treatment, and effects. A Style Profile never selects content, information architecture, pattern variants, or platform behavior. Hosts may set `honorsPreferredColorScheme: false` when multiple profiles must be compared in one presentation.

Apply `.interfaceDensity(.compact)`, `.standard`, or `.spacious` separately. Density changes broad collection rhythm—section spacing, item spacing, content margins, and metadata spacing—without encoding brand or visual personality. Existing screens inherit Neutral + Standard, whose values preserve the previous defaults.

The original proof covers the `MediaShelf` and `MediaGrid` Patterns plus the content-rich `MediaCard` Element. The same semantic vocabulary is now adopted by `PosterLockup`, `EditorialHero`, `SectionHeader`, and artwork placeholders. Collection patterns consume density; content Elements request Style Profile semantics without branching on profile identity; and explicit Element variants remain caller-selected. `HorizontalLockup` deliberately remains geometry-only so its children can supply the appropriate semantic hierarchy for each category.

`heroTitle`, `heroEyebrow`, and `heroSupporting` describe the hierarchy within a hero-level content presentation. They are intentionally broader than `PosterLockup`: use them only when content establishes the dominant hierarchy for an entire hero, not for section headings, ordinary card metadata, or component-specific sizing. Neutral preserves the established large-title hero treatment.

`prominentContentTitle` distinguishes feature-level content headings from ordinary card titles, while `itemSubtitle` provides readable secondary identity such as an artist or show name without promoting lower-priority metadata.

Profile values currently remain native SwiftUI values because the proof has no external token exchange requirement. If customizable tokens cross tool or platform boundaries later, expose only meaningful decisions in Design Tokens Community Group format and map them into these semantic Swift types; do not serialize system colors, text styles, or materials merely to replace native APIs.

## Lockups

Use `SquareLockup` for albums, shows, square events, rankings, and library items. Its direct inputs cover title, optional subtitle and metadata, optional badge accessibility, and the demonstrated standard, ranked, and library styles.

Use `PosterLockup` for portrait, full-bleed featured artwork with bounded title and supporting metadata. The caller supplies its reference-specific minimum height and may choose a semantic elevation; the active Style Profile defines how that elevation is rendered. Decorative imagery follows the text-owned bounds when accessibility content needs more height. The component does not provide a landscape mode, independent action region, long-form copy anatomy, or arbitrary overlay slots; those requirements need `MediaCard.standard` or a focused structural variant.

Artwork containers own displayed dimensions or aspect ratio, clipping, effects, and accessory bounds so placeholders and real images receive the same treatment and source bitmap dimensions cannot change layout. Supplied artwork owns its content and scaling behavior. `ArtworkContainer` is the shared bounded viewport used by lockups, posters, editorial presentations, and media cards. Standalone artwork surfaces use the Style Profile's subtle outline in every color scheme, which preserves their edge against dark or visually similar backgrounds. `ArtworkPlaceholder` supplies placeholder visuals and inherits the semantic artwork shape when no override is provided; it is not a universal artwork container. `ArtworkThumbnail` remains placeholder-specific, so its fixed thumbnail radius is not yet a shared shape convention.

Imagery treatment has two semantic roles. `.unmodified` preserves supplied artwork when text is outside its bounds. `.textLegibility` asks the active Style Profile for a contrast scrim when readable text overlays artwork. Components select the role from their anatomy; they never branch on profile identity, and callers do not configure arbitrary effect stacks.

Use `ArtworkImage` for bitmap artwork from an asset catalog. It resolves the requested asset before constructing the SwiftUI image and renders an `ArtworkPlaceholder` both when the name is `nil` and when the named resource cannot be loaded. It owns image content and `fill`/`fit` scaling only; surrounding artwork containers own displayed geometry, shape, clipping, overlays, accessory bounds, and elevation. Use `ArtworkPlaceholder` directly for intentionally generated playlist, station, category, and collection artwork.

### Fixture substitution

When reference artwork is unavailable, preserve four things: the content role, broad composition, crop tolerance, and title placement. Match portrait posters with portrait substitutes and landscape editorial imagery with landscape substitutes; do not change external-title anatomy into in-artwork-title anatomy. Keep fixture strings consistent with any title visibly embedded in the bitmap—for example, artwork reading “Blue Hour Arcade” must not be labeled as a different album. Disclose the unavailable canonical asset and identify the substitute in fixture or comparison notes. Placeholder-only previews are appropriate for fallback behavior; previews that validate crop, scaling, scrims, or geometry must include representative real bitmap artwork.

Use `HorizontalLockup` for sized leading artwork, flexible caller-supplied content, and an optional independent trailing accessory. Supply a scalar size for square artwork or `CGSize` for other proportions. The lockup applies the shared artwork shape and subtle outline; the caller owns imagery content, typography, hierarchy, actions, and accessibility. Bottom controls belong inside the content builder. Artwork/content and accessory vertical alignments are independent, while row padding and separators remain container responsibilities.

Use `VideoLockup` for lightweight landscape video artwork with a title and optional subtitle or metadata inside a shelf or grid. The caller supplies artwork and any reference-specific aspect ratio. Use `MediaCard` instead when the item needs a richer surface, overlay, or independent controls. Music video and interview shelves currently demonstrate `VideoLockup` on iOS and iPadOS.

`CircleLockup` is planned only after a concrete reference establishes its API. A separate `TrackLockup` is not currently needed.

Use `MediaCard` for landscape artwork and its semantic eyebrow, title, subtitle, metadata, and badge hierarchy. Select `.standard` for distinct artwork and text regions, long supporting copy, or independent actions. Select `.overlay` only for concise metadata layered over artwork; full-bleed artwork combined with long copy or action-heavy content is an anatomy mismatch that requires a focused structural variant or different component. The Style Profile never selects this structural layout. Its default artwork geometry is a 1.6 aspect ratio. Specialized example presentations may use the lower-level metadata and independent-actions slots and may select demonstrated geometry when the semantic initializer is insufficient.

Use `ElevatedTile` for compact square choices whose supplied primary content and optional footer belong on one raised surface. It owns square geometry and Style Profile/Density treatment while callers retain artwork, branding, accessibility labels, and native control semantics. Use `SquareLockup` instead when metadata belongs outside the artwork.

Use `BrowseCategoryCard` for category, genre, and topic choices whose title and decorative symbol share a colored surface. Select `.landscape` for two-column discovery grids or `.portrait` for tall three-column grids. The card owns its 14-point continuous shape and adaptive title hierarchy; callers own labels, symbols, backgrounds, actions, and collection layout.

Use `NavigationListItem` as the label of a native `NavigationLink` or `Button` for compact text destinations outside a native `List`. Select `.capsule` for a rounded system-fill surface with a disclosure indicator or `.plain` for a divided text row. The Element owns presentation while callers retain navigation and destination wiring.

Use `EpisodeCard` for a playable audio or video episode whose landscape artwork, date or status, episode title, optional summary, duration, media badge, and independent play and overflow controls form one stable anatomy. At standard Dynamic Type sizes, title and summary line limits bound copy while both remain layout participants; accessibility sizes grow intrinsically. It builds on `MediaCard`; use `PosterLockup` instead for portrait, full-bleed hero content and use `MediaCard` directly for non-episode cards.

Use `EpisodeRow` for compact episodic content with leading artwork, date or status, a title, optional supporting metadata and badge, and an independent overflow action. Supplying a duration and play action adds an independent playback control; without playback, duration and badge remain inline metadata. The caller supplies explicit specimen artwork geometry while the Element owns Style Profile treatment, Density rhythm, and accessibility composition. Use `EpisodeCard` when a landscape card surface and summary are required, and keep `HorizontalLockup` for geometry without episode semantics.

Use `EditorialHero` when an editorial eyebrow and heading sit outside and above landscape artwork. Its anatomy has no in-artwork metadata or action region. Those requirements are a different feature-card structure, not a reason to force controls into the hero or let decorative imagery influence heading layout. Bespoke branded editorial artwork, promotions, and simple discovery buttons remain example-owned compositions rather than separate Library card types.

## Collection patterns

- `MediaShelf` owns titled horizontal collection layout, scrolling policy, item spacing, content margins, and native scroll clipping. Item content must report its complete height so the shelf and following sections compose after the tallest item. Disable scroll clipping only for a component with an evidenced visual effect that intentionally crosses the scroll viewport; do not disable it globally to conceal incorrect bounds. `HorizontalCollectionItemSize` names compact, standard, and wide collection tiers, resolved for an explicit demonstrated sizing context. The current 161-, 249-, and 334-point values apply only to iPhone at Standard density and must not be treated as universal platform dimensions.
- `RankedShelf` supplies stable, one-based ranks while delegating presentation to its item closure.
- `MediaGrid` owns optional heading, columns, gaps, and horizontal margins for media, category, channel, and similar browsable collections. Its default gaps and margins resolve from `InterfaceDensity`; explicit specimen geometry still takes precedence.
- `ColumnMediaShelf` uses native `LazyHGrid` column-major placement for demonstrated multi-row episode and track collections. It and `RankedShelf` inherit content margins from `InterfaceDensity` unless the caller supplies an explicit override.
- Native `Section`, `NavigationLink`, `Label`, and navigation toolbars own standard structure and interaction; the Library does not wrap them.

Brand tint is applied at the example root and inherited by Library controls. Actions are caller-provided, accessory controls remain independent, and example-specific measurements do not become global component defaults.

## Platform scope

These APIs are demonstrated on iOS and iPadOS by the Music and Podcasts examples. Other Apple platforms are not yet documented.
