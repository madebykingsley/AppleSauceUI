
# AppleSauceUI Agent Instructions

AppleSauceUI is a research-driven SwiftUI pattern library focused on recreating the design language and interaction conventions of Apple's first-party apps across Apple platforms.

## Core implementation principles

Prefer native SwiftUI and Apple system APIs over custom implementations.

When recreating reference interfaces:

- Prefer semantic typography:
  - `.largeTitle`
  - `.title`
  - `.title2`
  - `.title3`
  - `.headline`
  - `.body`
  - `.callout`
  - `.footnote`
  - `.caption`
  - `.caption2`

- Prefer semantic colors and materials:
  - `.primary`
  - `.secondary`
  - system fills
  - system backgrounds
  - SwiftUI materials
  - system tint/accent behavior

- Prefer native controls and containers:
  - `NavigationStack`
  - `NavigationSplitView`
  - `TabView`
  - `List`
  - `Form`
  - `Menu`
  - `Button`
  - `Toggle`
  - `Picker`
  - `ScrollView`
  - native toolbar APIs
  - native search APIs

- Spacing:
  - Prefer intrinsic/system layout behavior first.
  - Introduce explicit spacing only after comparison demonstrates it is required.
- Layout:
  - Avoid fixed frames unless the reference pattern genuinely depends on fixed media dimensions.
- Accessibility:
  - Dynamic Type and semantic labels must survive the reconstruction.


Do not recreate system UI manually when an appropriate native API exists.

## Avoid arbitrary values

Do not use arbitrary constants merely to make a screenshot appear closer.

Avoid:
- arbitrary `.offset(...)`
- hardcoded text point sizes
- sampled RGB colors for system text/backgrounds
- manual recreations of navigation bars, tab bars, buttons, or other system UI
- hardcoded screenshot coordinates

Before adding an explicit numeric value, determine whether SwiftUI already provides the desired behavior semantically.

Explicit values are appropriate when they describe genuine content geometry, for example:
- media card dimensions
- image aspect ratios
- shelf spacing
- content margins
- corner radii for custom artwork
- intentionally fixed visual assets

When an explicit value is required, prefer a named local metric rather than an unexplained magic number.

## Visual reconstruction workflow

Reference screenshots live under:

`AppleSauceUI/Lab/References/`

Generated comparison artifacts live under:

`Artifacts/VisualComparisons/`

For visual-refinement tasks, use:

`Scripts/compare-ui <target>`

Example:

`Scripts/compare-ui media/apple-music/home`

When comparison artifacts are available, inspect:

- `reference.png`
- `actual.png`
- `overlay-50.png`
- `diff.png`

Refine discrepancies in this order:

1. overall hierarchy and structure
2. navigation/system chrome
3. major geometry and proportions
4. spacing and alignment
5. semantic typography
6. colors/materials
7. minor decorative details

Do not optimize individual pixels before major structural discrepancies are resolved.

Do not resize or alter the canonical reference image to make a comparison pass.

## Library-first architecture

Examples are thin demonstrations of the shared UI system. They should primarily contain app shells, screens, navigation and state, domain models, fixtures/assets, and mappings from domain data into Library presentation inputs.

Library owns reusable visual presentation and behavior, including typography, semantic foreground hierarchy, accessibility composition, controls, card structure, and collection layout. A view does not remain example-owned merely because its initializer accepts an app model; map the model to narrow, neutral presentation data and use the Library component directly.

Before implementing UI, inspect existing Library components and representative consumers. Evolve the smallest semantic component that supports demonstrated differences. Keep distinct concepts such as episode cards, event tiles, and promotional cards separate rather than creating a universal configurable card.

- Keep fixtures and models outside screen view files.
- Keep screen bodies as readable compositions of Library elements and patterns.
- Prefer semantic presentation inputs for the normal path; reserve low-level content slots for artwork and genuinely custom content.
- Collection abstractions accept identifiable items and caller-provided item views, never app-domain models.
- Preserve semantic distinctions such as static versus actionable headers and independent child controls.
- Example-owned visual views are exceptions limited to bespoke artwork/assets or app-shell behavior. Document each remaining exception.
- Do not add forwarding wrappers that only pass data, defaults, or content into a Library component.
- Brand tint belongs at the app/example root. Library controls inherit it.
- Library must never depend on `Examples`.

When a reusable presentation is added or changed, update the Library index and documentation in the same change. Verify all consumers before deleting superseded example code.

## View files and previews

- Give every SwiftUI `View` its own file named after the type. Do not collect independent components in umbrella files.
- Extract private helper `View` types into their own appropriately named files and keep their access as narrow as practical.
- Keep computed view properties and small `@ViewBuilder` methods with their owner; do not turn every stack into a component.
- Small supporting enums or configuration types may remain beside their sole owning component. Put shared models and configuration in separate files.
- Keep each component's preview declarations in its corresponding file under `#if DEBUG`. Multiple preview variations do not require separate files.
- Apply the same file and preview conventions to example screens and app-shell views.
- Name previews consistently: `ComponentName — Variants`, plus `— Long Content`, `— Accessibility`, or `— Alternate Width` when those cases materially affect the component.

## Library discovery and documentation

Before implementing UI, consult `AppleSauceUI/Library/README.md` for existing elements and patterns. Read the relevant component documentation and representative consumers before using or extending an abstraction.

When extracting or changing a library component, update its index entry, public API documentation, and any component README in the same change. Document when to use it, caller responsibilities, supported variants/platforms, and demonstrated uses. Keep examples aligned with the current API.

Reuse components when their documented responsibilities fit. If they do not fit, keep the implementation local and explain the mismatch rather than adding speculative configuration.


## Platform behavior

Do not assume that one interface should be identically resized across Apple platforms.

Prefer platform-native adaptations for:
- iOS
- iPadOS
- macOS
- watchOS
- tvOS
- visionOS

A pattern does not need to support every platform.

Document unsupported platforms rather than forcing inappropriate parity.

## Scope discipline

Keep changes focused on the current task.

Do not:
- redesign unrelated screens
- introduce large frameworks without need
- add third-party dependencies without strong justification
- refactor example-specific code into reusable abstractions prematurely

Favor small, observable iterations.

For visual-refinement work:
1. make a meaningful change
2. build/run
3. regenerate comparison artifacts
4. inspect results
5. continue based on evidence

## Screen-Driven Development

When implementing a new AppleSauce example screen, treat the screen as a **design-system research specimen**, not as a reusable component itself.

The goal is:

1. Build a convincing, idiomatic SwiftUI screen.
2. Reuse existing AppleSauce Elements and Patterns wherever appropriate.
3. Discover missing reusable Elements or Patterns through implementation.
4. Extract only abstractions that encode reusable design knowledge.
5. Leave screen-specific composition local to the example screen.

Do not create reusable screen-level or Recipe-level SwiftUI abstractions unless explicitly requested.

---

## Native SwiftUI First

Use native SwiftUI APIs whenever they already express the required behavior correctly.

Prefer native:

- `NavigationStack`
- `NavigationSplitView`
- `List`
- `Section`
- `NavigationLink`
- `Label`
- `Toolbar`
- `Grid`
- `LazyVGrid`
- `LazyHGrid`
- `ScrollView`
- `ForEach`
- native controls
- system materials
- system navigation behavior

Do not introduce AppleSauce wrappers that merely rename or lightly restyle native SwiftUI behavior.

An AppleSauce abstraction should exist because it encodes reusable Apple-style design knowledge, not because SwiftUI syntax can be wrapped.

---

## Reuse Before Creating

Before creating any new Element or Pattern:

1. Search the existing AppleSauce library.
2. Identify the closest existing abstraction.
3. Determine whether the new requirement is:
   - already supported
   - a legitimate variant
   - a small semantic extension
   - genuinely a different abstraction

Prefer extending an existing Element or Pattern when the new requirement preserves the same:

- semantic purpose
- basic anatomy
- interaction model
- content hierarchy
- responsive behavior

Create a new abstraction only when at least one of those meaningfully differs.

### Extension threshold

Prefer extending an existing abstraction when approximately **80% or more of the semantic structure and behavior is shared** and the difference can be expressed with:

- one small variant enum
- one optional semantic capability
- one additional content slot
- a small number of non-orthogonal parameters

Do not use the 80% threshold mechanically. Semantic identity matters more than line-count similarity.

A new abstraction is usually warranted when extending the old one would require:

- multiple unrelated booleans
- several independently combinable configuration switches
- conditionals throughout the implementation
- substantially different anatomy
- substantially different interaction
- substantially different responsive behavior
- a name that no longer accurately describes all variants

Avoid configuration-object abstractions that attempt to represent many unrelated designs through dozens of options.

Prefer:

`MediaCard(style: .poster)`

over:

`UniversalCard(showImage: true, imagePosition: ..., overlay: ..., rank: ..., footer: ..., etc.)`

---

## Evidence Before Extraction

Do not extract every visually distinctive object into the library.

Keep a component local to the screen when it appears to solve only that screen's specific composition.

Extract an Element or Pattern when there is evidence it represents reusable design grammar.

Strong evidence includes:

- the structure already appears elsewhere in AppleSauce
- the same concept appears in multiple Apple first-party apps
- it could plausibly be used in at least two distinct screen contexts
- the same implementation would otherwise be duplicated
- the abstraction expresses meaningful semantic intent an agent would benefit from selecting

Examples:

`MediaShelf`
→ reusable Pattern

`PosterLockup`
→ reusable Element

one-off promotional banner unique to a single screen
→ keep local until reuse is demonstrated

When uncertain, prefer leaving code local. Extraction can happen later.

---

## Element vs Pattern

### Element

A relatively self-contained semantic UI object.

Examples:

- `MediaCard`
- `PosterLockup`
- `EpisodeRow`
- `MetadataBadge`
- `ArtworkPlaceholder`

An Element owns:

- semantic anatomy
- its own meaningful structural variants
- element-level behavior

### Pattern

Defines relationships among Elements and/or repeated content.

Examples:

- `MediaShelf`
- `MediaGrid`
- `RankedShelf`
- `MediaList`

A Pattern owns:

- arrangement
- collection behavior
- section relationships
- responsive collection structure

Do not create a Pattern merely because multiple Elements happen to be placed inside a `VStack`.

---

## Style Profile Ownership

New reusable Elements and Patterns should use the existing Style Profile system from the beginning.

Style Profile owns reusable visual language such as:

- typography character
- semantic foreground hierarchy
- colors
- surfaces
- shapes
- imagery treatment
- scrims
- shadows
- outlines
- symbol rendering
- motion character

Do not branch on profile identity.

Forbidden:

```swift
if styleProfile == .entertainment {
    ...
}
```

Use semantic style roles instead.

Do not add a new semantic role unless the existing vocabulary is genuinely insufficient.

Prefer general semantic roles over component-specific tokens.

Avoid names such as:

- `posterTitleColor`
- `musicCardRadius`
- `episodeSubtitleFont`

Prefer concepts such as:

- `foreground.onMedia`
- `typography.contentTitle`
- `shape.content`
- `shadow.elevated`

---

## Density Ownership

`InterfaceDensity` owns reusable spacing rhythm such as:

- content padding
- gaps
- section spacing
- margins
- metadata rhythm
- compactness

Style Profile must not own density.

Do not add density values for one-off geometry.

Explicit example-screen geometry may override density when reproducing a deliberate layout relationship.

---

## Example Screen Ownership

Example screens may own:

- content selection
- section order
- screen-specific composition
- deliberate geometry required by the specimen
- local one-off promotional compositions
- navigation destination wiring
- fake/demo data

Example screens should not own reusable visual language that belongs in Style Profile.

Do not extract a reusable `FooScreen`, `MediaDetailRecipe`, or similar screen-level component unless explicitly requested.

For now, Recipes are out of scope.

---

## Screenshot and Visual-Reference Budget

Minimize screenshot capture and image-processing work.

Screenshots are a verification tool, not the primary implementation loop.

### Default workflow

1. Inspect the provided reference once.
2. Identify major geometry and hierarchy.
3. Implement from code and existing AppleSauce conventions.
4. Build and inspect the simulator only after the major structure is complete.
5. Perform at most **one primary screenshot comparison pass**.
6. Make code corrections based on that comparison.
7. Perform **one final verification capture only if materially necessary**.

Do not repeatedly:

- capture screenshots after small edits
- perform iterative pixel-diff loops
- process/crop/analyze many screenshots
- chase minor first-party rendering differences

Unless explicitly requested, prioritize:

- hierarchy
- margins
- section cadence
- element sizing
- content relationships
- native interaction
- reusable design grammar

over exact pixel matching.

Accept minor differences caused by:

- private Apple components
- unavailable artwork
- native material rendering
- system typography rendering
- status-bar state
- private first-party effects

If the implementation is structurally correct and visually convincing, stop.

---

## Visual Matching Priority

When reproducing a reference, prioritize in this order:

1. semantic structure
2. navigation model
3. section hierarchy
4. major geometry
5. content margins
6. item sizing
7. spacing rhythm
8. typography hierarchy
9. imagery treatment
10. minor decorative differences

Do not compromise architecture merely to match a screenshot more precisely.

---

## Extraction Workflow

For each new screen:

### 1. Inventory

Before coding, identify:

- existing Elements that can be reused
- existing Patterns that can be reused
- likely missing capabilities
- likely screen-local compositions

### 2. Build

Construct the screen using:

- native SwiftUI
- existing AppleSauce abstractions
- local screen-specific code

Do not prematurely extract new abstractions.

### 3. Observe

After the screen structure works, inspect duplication and repeated semantic relationships.

Ask:

- Is this already represented elsewhere?
- Would another screen plausibly need this?
- Is this an Element, Pattern, or merely local composition?
- Could an existing abstraction support this cleanly?

### 4. Extract

Only then:

- extend an existing abstraction, or
- create a new Element/Pattern

Keep APIs semantic and small.

### 5. Validate

Verify that extraction:

- reduces duplication
- improves semantic clarity
- does not create configuration soup
- remains Style Profile compatible
- preserves native SwiftUI behavior

---

## Change Discipline

Do not refactor unrelated parts of the library while building a specimen screen.

Do not create speculative abstractions for future screens.

Do not add new Style Profiles during screen extraction unless explicitly requested.

Do not add Recipe implementations.

Do not convert every numeric value into a token.

Do not create abstractions merely to reduce file length.

Prefer fewer, stronger abstractions.
