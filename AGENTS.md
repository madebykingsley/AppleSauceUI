# AppleSauceUI Agent Instructions

AppleSauceUI is a research-driven SwiftUI pattern library informed by the design language and interaction conventions of Apple's first-party apps across Apple platforms.

Treat each reconstructed screen as a **design-system research specimen**: build a convincing, idiomatic screen, reuse proven Elements and Patterns, and discover missing reusable design knowledge. The screen itself is not the reusable API.

## 1. Native SwiftUI and platform behavior

Prefer native SwiftUI and Apple system APIs whenever they express the required behavior correctly. Do not manually recreate system UI when an appropriate native API exists.

- Use native navigation and chrome: `NavigationStack`, `NavigationSplitView`, `NavigationLink`, `TabView`, toolbar APIs, and search APIs.
- Use appropriate native containers: `List`, `Form`, `Section`, `ScrollView`, `Grid`, `LazyVGrid`, `LazyHGrid`, and `ForEach`.
- Use native controls and semantics: `Button`, `Menu`, `Toggle`, `Picker`, and `Label`.
- Prefer semantic typography: `.largeTitle`, `.title`, `.title2`, `.title3`, `.headline`, `.body`, `.callout`, `.footnote`, `.caption`, and `.caption2`.
- Prefer semantic colors, system fills/backgrounds, SwiftUI materials, and native tint/accent behavior.
- Preserve Dynamic Type, semantic accessibility labels, native interaction, and system navigation behavior.
- Prefer intrinsic sizing and system layout behavior. Use fixed frames only when genuine content geometry, such as fixed media dimensions, requires them.

AppleSauce abstractions must encode reusable Apple-style design knowledge. Do not add wrappers that merely rename native SwiftUI syntax or lightly restyle system behavior.

Adapt to platform conventions rather than identically resizing one interface across iOS, iPadOS, macOS, watchOS, tvOS, and visionOS. A Pattern need not support every platform; document unsupported platforms instead of forcing inappropriate parity.

## 2. Library architecture and ownership

### Library and Examples

`Library` owns reusable visual presentation and behavior: typography, semantic foreground hierarchy, accessibility composition, controls, card structure, and collection layout. Style Profile and Density responsibilities are defined below.

`Examples` are thin demonstrations of the shared system. They own:

- App shells, screens, navigation, state, and destination wiring.
- Domain models, fixtures, assets, and fake/demo data.
- Mappings from domain data to narrow, neutral Library presentation inputs.
- Content selection, section order, and screen-specific composition.
- Deliberate specimen geometry and local one-off promotional compositions.

Keep screen bodies readable compositions of Elements, Patterns, and native views. Keep fixtures and models outside screen view files.

A view does not remain example-owned merely because its initializer accepts an app model. Map domain data to semantic presentation inputs and use the Library component directly when its responsibility fits.

- Prefer semantic presentation inputs for the normal path; reserve low-level content slots for artwork and genuinely custom content.
- Collection abstractions accept identifiable items and caller-provided item views, never app-domain models.
- Preserve distinctions such as static versus actionable headers and independent child controls.
- Do not add forwarding wrappers that only pass data, defaults, or content into a Library component.
- Brand tint belongs at the app/example root; Library controls inherit it.
- `Library` must never depend on `Examples`.

Keep bespoke artwork, app-shell behavior, and truly screen-specific compositions local. Also keep uncertain extraction candidates local until evidence supports promotion. Document remaining example-owned visual exceptions and why existing Library responsibilities do not fit; do not leave reusable presentation in Examples merely for convenience.

### Elements and Patterns

**Element:** A relatively self-contained semantic UI object. It owns semantic anatomy, meaningful structural variants, and element-level behavior.

Examples: `MediaCard`, `PosterLockup`, `EpisodeRow`, `MetadataBadge`, and `ArtworkPlaceholder`.

**Pattern:** Defines relationships among Elements and/or repeated content. It owns arrangement, collection behavior, section relationships, and responsive collection structure.

Examples: `MediaShelf`, `MediaGrid`, `RankedShelf`, and `MediaList`.

Do not create a Pattern merely because several Elements appear inside a `VStack`.

### Style Profile ownership

New reusable Elements and Patterns must use the existing Style Profile system from the beginning.

Style Profile owns reusable visual language:

- Typography character and semantic foreground hierarchy.
- Colors, surfaces, and shapes.
- Imagery treatment and scrims.
- Shadows and outlines.
- Symbol rendering and motion character.

Use semantic style roles; never branch on profile identity, such as `if styleProfile == .entertainment`.

Reuse the existing vocabulary. Add a semantic role only when existing roles are genuinely insufficient, and prefer general roles over component-specific tokens:

| Prefer | Avoid |
| --- | --- |
| `foreground.onMedia` | `posterTitleColor` |
| `typography.contentTitle` | `episodeSubtitleFont` |
| `shape.content` | `musicCardRadius` |
| `shadow.elevated` | Component-specific shadow tokens |

Example screens must not own reusable visual language that belongs in Style Profile. Do not add new Style Profiles during screen extraction unless explicitly requested.

### Density ownership

`InterfaceDensity` owns reusable spacing rhythm: content padding, gaps, section spacing, margins, metadata rhythm, and compactness.

Style Profile must not own density. Do not add density values for one-off geometry or convert every numeric value into a token. Explicit example-screen geometry may override density when reproducing a deliberate layout relationship.

### Recipes and screen-level abstractions

Recipes are out of scope for ordinary screen-building and extraction work. Do not create Recipe implementations or agent-facing Recipe documentation as an automatic follow-up.

Do not extract reusable `FooScreen`, `MediaDetailRecipe`, or similar screen-level SwiftUI components unless explicitly requested. Leave concrete screen composition in Examples.

## 3. Library discovery, reuse, and extraction

Before implementing UI, consult `AppleSauceUI/Library/README.md`, relevant component documentation, and representative consumers. Identify the closest existing Element or Pattern and determine whether the requirement is already supported, a legitimate variant, a small semantic extension, or a different concept.

Reuse an abstraction when its documented responsibilities fit. Otherwise, extend it only if the semantic identity remains intact; keep the implementation local and explain the mismatch when it does not fit and extraction is not yet justified.

### Extension threshold

Prefer extending an existing abstraction when it preserves the same:

- Semantic purpose and basic anatomy.
- Interaction model and content hierarchy.
- Responsive behavior.

The difference should fit a small semantic addition: one variant enum, one optional capability, one additional content slot, or a few closely related parameters.

As a rough heuristic, extension often makes sense when about **80% or more of semantic structure and behavior remains shared**. Do not apply the percentage mechanically or measure it by shared lines of code; semantic identity is decisive.

A separate abstraction is usually warranted when purpose, anatomy, interaction, hierarchy, or responsive behavior meaningfully differs, or extension would require:

- Multiple unrelated Boolean flags or independently combinable switches.
- Conditionals throughout the implementation.
- A name that no longer accurately describes every variant.
- A configuration object attempting to represent unrelated designs through many options.

Prefer focused semantic choices such as `MediaCard(style: .poster)`. Keep distinct concepts such as episode cards, event tiles, and promotional cards separate rather than building a universal configurable card.

### Evidence before extraction

Extract only when there is evidence of reusable design grammar: demonstrated reuse across contexts or a clear semantic concept with credible applicability to at least two distinct screen contexts.

Evidence can include an existing AppleSauce counterpart, recurrence across Apple first-party apps, implementation duplication, or meaningful semantic intent an agent can select. Do not invent speculative future needs to justify extraction.

For example, `MediaShelf` is a reusable Pattern and `PosterLockup` a reusable Element; a promotional banner unique to one screen stays local until reuse is supported.

Do not extract every visually distinctive object or create abstractions merely to shorten files. When uncertain, keep code local. Prefer fewer, stronger abstractions.

## 4. Screen-driven workflow

### Inventory

Before coding, identify existing Elements and Patterns to reuse, likely missing capabilities, and likely screen-local compositions. Apply the discovery and extension rules above.

### Build

Construct the screen with native SwiftUI, existing AppleSauce abstractions, and local screen-specific code. Establish the screen's structure before extracting new abstractions.

### Observe

Once the structure works, inspect duplication and repeated semantic relationships:

- Is the concept represented elsewhere, or useful in another credible screen context?
- Is it an Element, a Pattern, or merely local composition?
- Could an existing abstraction support it cleanly?

### Extract

When the task includes extraction and evidence supports it, extend an existing abstraction or create a focused Element/Pattern. Keep APIs semantic and small, and preserve the ownership boundaries above.

### Validate

Verify that extraction reduces duplication, improves semantic clarity, avoids excessive configuration, remains Style Profile compatible, and preserves native SwiftUI behavior.

Verify affected consumers before deleting superseded example code. Use the visual-verification mode below; extraction does not reset the screenshot budget or automatically authorize iterative visual refinement.

## 5. Visual reconstruction and verification

### Explicit values

Do not use arbitrary constants merely to make a screenshot appear closer. Before adding a numeric value, determine whether SwiftUI already expresses the intended behavior semantically.

Avoid arbitrary offsets, hardcoded text point sizes, sampled RGB values for system text/backgrounds, manually recreated system chrome/controls, and hardcoded screenshot coordinates.

Explicit values are appropriate for evidenced content geometry: media dimensions, image aspect ratios, shelf spacing, content margins, custom artwork radii, and intentionally fixed visual assets. Prefer named local metrics over unexplained magic numbers.

Use intrinsic/system spacing first. Introduce explicit spacing only when comparison with the reference demonstrates the need; this does not require another capture after each edit.

### Matching priority

Resolve discrepancies in this order:

1. Semantic structure and overall hierarchy.
2. Navigation model and native system chrome.
3. Section hierarchy.
4. Major geometry and proportions.
5. Content margins.
6. Item sizing.
7. Spacing rhythm and alignment.
8. Semantic typography hierarchy.
9. Imagery treatment, colors, and materials.
10. Minor decorative details.

Do not compromise architecture, accessibility, or native interaction for closer screenshot alignment. Resolve structural discrepancies before optimizing individual pixels.

### Ordinary new-screen work: strict screenshot budget

Screenshots are a verification tool, not the primary implementation loop. Unless the task explicitly calls for dedicated visual refinement, follow this budget for the screen task as a whole:

1. Inspect the supplied reference once and identify major geometry and hierarchy.
2. Implement from code and existing AppleSauce conventions.
3. Build and inspect the simulator after the major structure is complete.
4. Perform at most **one primary screenshot comparison pass**.
5. Make code corrections based on that comparison.
6. Perform **one final verification capture only if materially necessary**.

This allows at most two implementation captures: the primary comparison and a conditional final verification. Do not restart the budget after extraction or individual fixes.

Do not repeatedly capture after small edits, run iterative pixel-diff loops, process/crop/analyze many screenshots, or chase minor first-party rendering differences. Minimize image-processing work within each permitted pass.

Prioritize hierarchy, margins, section cadence, element sizing, content relationships, native interaction, and reusable design grammar over exact pixel matching.

Accept minor differences caused by private Apple components/effects, unavailable artwork, native materials, system typography rendering, and status-bar state. Stop when the screen is structurally correct and visually convincing.

### Dedicated visual-refinement tasks: evidence-driven iteration

When visual refinement is explicitly the task, iterative comparison is allowed within any task-specific limits:

1. Identify the largest remaining discrepancy and make a meaningful, focused change.
2. Build/run.
3. Regenerate comparison artifacts.
4. Inspect results and continue based on evidence.

Use the matching priority above and avoid unproductive pixel chasing. An ordinary screen implementation must not silently become a dedicated refinement task.

### References and comparison tooling

- Canonical references: `AppleSauceUI/Lab/References/`.
- Generated comparisons: `Artifacts/VisualComparisons/`.
- Comparison command: `Scripts/compare-ui <target>`.
- Example: `Scripts/compare-ui media/apple-music/home`.

Use this tooling for dedicated visual refinement; when used during ordinary screen work, it must stay within the screenshot budget.

When artifacts are available, inspect `reference.png`, `actual.png`, `overlay-50.png`, and `diff.png` as part of the permitted comparison pass. Use current artifacts reflecting the intended screen and build.

Never resize or alter the canonical reference to make a comparison pass. State what visual verification was actually performed and any remaining unverified differences.

## 6. Repository hygiene and change discipline

### View files and previews

- Give every SwiftUI `View` its own file named after the type; do not collect independent components in umbrella files.
- Put private helper `View` types in appropriately named files and keep access as narrow as practical.
- Keep computed view properties and small `@ViewBuilder` methods with their owner; do not turn every stack into a component.
- Small supporting enums/configuration types may remain beside their sole owner. Put shared models and configuration in separate files.
- Keep previews in the corresponding component file under `#if DEBUG`; multiple variations do not require separate files.
- Apply these conventions to example screens and app-shell views as well as Library components.
- Name previews `ComponentName — Variants`, adding `— Long Content`, `— Accessibility`, or `— Alternate Width` when those cases materially affect the component.

### Documentation and scope

When adding, extracting, or changing reusable presentation, update the Library index entry, public API documentation, and any component README in the same change. Document when to use it, caller responsibilities, supported variants/platforms, and demonstrated uses. Keep examples aligned with the current API.

Keep work focused on the current task. Do not redesign unrelated screens, refactor unrelated Library code, introduce large frameworks without need, or add third-party dependencies without strong justification.

Favor small, observable iterations. Preserve screen-specific decisions locally, extract only supported reusable knowledge, and report validation honestly.
