
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
