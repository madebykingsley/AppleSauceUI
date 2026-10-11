# Apple UI Internals and AppleSauce Architecture

## Research evidence

### Observed

Binary inspection of the iOS 27 Simulator versions of `MusicUI.framework` and `AppStoreComponents.framework` found shared use of the term **Lockup** for composed content presentations.

MusicUI symbols include `SquareLockup`, `PosterLockup`, `CircleLockup`, `HorizontalLockup`, and `TrackLockup`, along with specialized and adaptive lockups. Several geometry-oriented lockups conform to `JetEngine.ComponentModel`, and recovered names indicate explicit presentation and styling variants.

AppStoreComponents symbols include `ASCLockup`, `ASCLockupView`, `ASCLockupContentView`, presenter and theme types, display contexts, and size-dependent methods. Both frameworks reference private `JetEngine` infrastructure.

### Inferred

The symbols suggest that Apple uses Lockup as a recurring term for a self-contained content presentation and separates item presentation from collection layout. They do not prove that the frameworks share concrete renderers, that a recovered type produced a particular screenshot, or that Apple uses AppleSauce's four-layer taxonomy.

### Limitations

Private binary symbols cannot establish original source structure, exact geometry, typography, accessibility behavior, current design intent, or cross-application reuse. AppleSauce does not link against or reproduce private frameworks. Raw dumps and generated symbol files are intentionally excluded from the repository.

## AppleSauce decisions

AppleSauce uses four conceptual layers without requiring a matching directory hierarchy:

- **Foundations**: shared visual and behavioral primitives.
- **Elements**: self-contained presentations and controls.
- **Patterns**: collection layout, scrolling, spacing, and interaction.
- **Recipes**: screenshot-driven example applications and screens.

A **Lockup** is an individual content presentation combining artwork, semantic text, optional metadata, and optional actions. Current public naming is geometry-oriented:

- `SquareLockup` presents square artwork above metadata and supports demonstrated standard, ranked, and library hierarchies.
- `PosterLockup` presents portrait, full-bleed featured artwork. Its dimensions belong to the consuming recipe.
- `HorizontalLockup` presents leading artwork beside metadata and an optional independent accessory.

`CircleLockup` is intentionally deferred until a reference or concrete recipe establishes its layout and accessibility contract. `TrackLockup` is unnecessary while current track presentations fit `HorizontalLockup`.

Editorial, episode, trailer, promotional, and discovery components retain semantic names when their hierarchy or controls are materially different from geometry-based artwork lockups.

Patterns own collections; Lockups own individual items. `MediaShelf`, `MediaGrid`, and `RankedShelf` accept identifiable data and caller-provided item views, never recipe-domain models.

## Open questions

- Which first-party references provide a concrete circular artwork presentation?
- Do future poster references require metadata below artwork in addition to the demonstrated overlay treatment?
- Which platform adaptations should be encoded after macOS, tvOS, watchOS, or visionOS recipes exist?
- Can accessibility inspection correlate recovered Lockup names with specific first-party presentations?
