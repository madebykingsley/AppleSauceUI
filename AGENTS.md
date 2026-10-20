# AppleSauceUI Agent Instructions

AppleSauceUI is a research-driven SwiftUI pattern library informed by the design language and interaction conventions of Apple's first-party apps across Apple platforms.

Treat each reconstructed screen as a **design-system research specimen**: build a convincing, idiomatic screen, reuse proven Elements and Patterns, and discover missing reusable design knowledge. Generalizing the UI concepts discovered in each screen into the Library is part of completing the screen, even when the request only says to recreate it. The screen itself is not the reusable API.

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
- Deliberate specimen geometry and supplied artwork/branding content; reusable promotional structure belongs in Library.

Keep fixtures and models outside screen view files. Follow the example-screen composition rules below when mapping their data into Library presentation.

A view does not remain example-owned merely because its initializer accepts an app model. Map domain data to semantic presentation inputs and use the Library component directly when its responsibility fits.

- Prefer semantic presentation inputs for the normal path; reserve low-level content slots for artwork and genuinely custom content.
- Collection abstractions accept identifiable items and caller-provided item views, never app-domain models.
- Preserve distinctions such as static versus actionable headers and independent child controls.
- Brand tint belongs at the app/example root; Library controls inherit it.
- `Library` must never depend on `Examples`.

Attempt to generalize every custom visual element and collection arrangement introduced by a screen. Library owns the resulting Elements and Patterns; Examples compose them and supply content. Keep bespoke artwork content, app-shell behavior, and the overall screen composition local, but separate artwork from reusable surfaces, hierarchy, layout, and accessibility. A single demonstrated screen is enough to establish a focused generalized abstraction. Uncertainty or lack of a second consumer is not a reason to leave custom UI in Examples. If generalization would genuinely harm semantic clarity or native behavior, document the concrete exception and why reuse, extension, and a focused new abstraction do not fit.

### Example-screen composition

Example screens are living documentation of AppleSauce. Keep their major visual hierarchy readable directly in source.

- Declare major AppleSauce Patterns, such as `MediaShelf`, `ColumnMediaShelf`, `RankedShelf`, `MediaGrid`, and `MediaList`, directly in the screen's `body`. Do not hide them or primary screen sections behind view-returning helper methods, computed properties, or forwarding Views.
- Prefer keeping Library Elements visible in those Pattern item closures too when mapping example/domain data into their inputs is simple. A direct `MediaShelf` → `SquareLockup` composition makes both Library responsibilities apparent.
- Do not create example-specific `View` types solely to map fixture/model fields into an existing Library Element, or forwarding wrappers that only pass data, defaults, or content through. Inline those mappings at the composition site. Repetition, use across multiple screens, a shorter file, or a separate preview does not by itself justify wrapping a simple mapping.
- Substantial custom item presentation is a signal to identify and generalize a Library Element, not to introduce an example-specific component. Extract collection relationships separately as Patterns when they encode meaningful layout or behavior.
- Example-owned child Views are limited to app-shell/state wiring, bespoke artwork content, or a documented exception under the ownership rules above. They must not conceal reusable presentation or require Library APIs to consume app-domain models.
- Small computed view properties and `@ViewBuilder` methods remain appropriate for implementation details, local conditional fragments, and small chrome fragments that do not conceal the major hierarchy. Do not replace a trivial adapter View with an equally opaque view factory.
- Prefer explicit declarative composition for static specimen screens. Do not introduce a generic section array or section-kind switch merely to reduce repetition; use data-driven section structure only when the screen genuinely requires it.

Simple field mapping belongs at the call site; substantial item presentation belongs in a generalized Library Element. Keep major Patterns visible in either case. Clear source-to-preview navigation is useful, but does not justify unnecessary abstractions or guarantee a particular Xcode Preview selector result.

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

Reserve **Recipe** for future agent-facing composition guidance, not SwiftUI factory namespaces or example-specific presentation adapters. Do not introduce Swift `Recipe`/`Recipes` types or static view factories masquerading as Recipes. Place composition with its actual owner under the rules above.

Recipes are out of scope for ordinary screen-building and extraction work. Do not create Recipe implementations or agent-facing Recipe documentation as an automatic follow-up.

Do not extract reusable `FooScreen`, `MediaDetailRecipe`, or similar screen-level SwiftUI components unless explicitly requested. Leave concrete screen composition in Examples.

## 3. Library discovery, reuse, and extraction

Before implementing UI, inspect the reference, then consult `AppleSauceUI/Library/README.md`, relevant component documentation, and representative consumers. Identify the closest existing Element or Pattern and determine whether the requirement is already supported, a legitimate variant, a small semantic extension, or a different concept.

Reuse an abstraction only when its documented responsibilities fit after comparing all four of these dimensions:

- **Anatomy:** semantic content, hierarchy, and accessibility composition.
- **Geometry ownership:** which layer owns size, aspect ratio, clipping, spacing, and collection placement.
- **Interaction:** control independence, actions, navigation, focus, and selection behavior.
- **Adaptive behavior:** resizing, Dynamic Type, platform conventions, and compact/expanded arrangements.

Otherwise, extend it when its semantic identity remains intact, or create a focused generalized Element or Pattern. Visual resemblance or a shared image is not enough to justify component reuse. **Component reuse** shares semantic presentation and behavior; **asset reuse** shares only supplied artwork, symbols, colors, or other content resources. An asset may be reused while its consumers remain distinct components. Moving an app-specific View into Library unchanged, or merely giving it a generic name, does not satisfy generalization.

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

### Generalization by default

For every custom UI concept, identify the smallest coherent design grammar that applies beyond the current app's names and fixtures. Generalize that concept into Library as part of ordinary screen work. Do not require a second implemented consumer or a separate extraction request.

- Compare anatomy, geometry ownership, interaction, and adaptive behavior with existing Library components and representative Music, Podcasts, App Store, or other available examples. Prefer reuse or a small semantic extension before creating a sibling component.
- Name APIs for their reusable responsibility rather than the originating app or screen. For example, station shortcuts may reveal an elevated tile Element and a category/channel browsing grid Pattern; an on-air card may already fit `MediaCard` with a focused extension. These are candidates to assess, not mandated new types.
- Separate the Element from its collection Pattern and its supplied artwork. A tile owns its surface and content anatomy; a grid owns arrangement and adaptation; station logos and fixture strings are content.
- Remove dependencies on example models, brand-specific string parsing, fixture identities, and app-specific conditionals. Accept narrow semantic presentation inputs, caller-supplied artwork, and actions where appropriate.
- Generalize only the dimensions established by the current design and inspected counterparts. Do not invent options, unsupported platform claims, or hypothetical features. Use representative neutral preview content to demonstrate that the API is independent of Radio or any other originating domain.
- Generalization does not mean one universal component. Preserve focused concepts when their anatomy or behavior differs; avoid unrelated Boolean flags and configuration bags. Native SwiftUI remains appropriate for ordinary composition and system controls; do not create a Library wrapper for every stack, button, or modifier.

A completed screen must not leave custom visual components in Examples merely because they are new, used once, or convenient to keep local. Record any concrete exceptions and their reasoning. Components must be discoverable through the Library index and documentation, not merely present in its source directory.

## 4. Screen-driven workflow

### Inspect

Inspect the supplied reference and inventory each visual concept, content relationship, interaction, and adaptive expectation. Inspect existing Elements, Patterns, documentation, and representative consumers. Classify likely reuse, extensions, missing generalized abstractions, assets, and example-owned wiring using the four-dimension reuse comparison above.

### Prove with actual content

Construct the consumer with native SwiftUI and AppleSauce abstractions using the actual fixture strings, artwork, controls, and states intended for the specimen. Prove the hierarchy, layout, scrolling, artwork bounds, readable-content fit, control reachability, and relevant adaptive behavior before finalizing an abstraction. Placeholder rectangles or shortened copy do not prove layout correctness. Temporary local implementations may establish structure while answering:

- What general concept does this presentation express after removing app-specific content and branding?
- Is it an Element, a Pattern, or merely local composition?
- Could an existing abstraction support it cleanly?

### Generalize

As a required part of screen work, reuse or extend existing abstractions and extract missing generalized Elements/Patterns. Replace temporary custom example components with direct Library composition. Keep APIs semantic and small, and preserve the ownership boundaries above. Do not wait for a separate extraction request.

Validate that generalization captures the visual concept independently of example models and branding, improves semantic clarity, avoids excessive configuration, remains Style Profile and Density compatible, and preserves native SwiftUI behavior. Demonstrate representative content from another domain in previews without claiming an unimplemented production consumer. Review the screen for custom presentation left inline as well as in separate View files.

### Verify the final consumer

Render and inspect the final consumer after extraction or reuse changes, with actual content and at relevant sizes or states. Verification of a temporary proof does not verify the generalized component or its final consumer. Verify affected consumers before deleting superseded example code, and follow the completion gates and refinement budget below.

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

### Visual completion gates and cosmetic-refinement budget

Rendering the final consumer is mandatory whenever the environment can run it. Inspect it with actual content at the reference configuration and any materially different supported size, Dynamic Type setting, or interaction state implicated by the change. Screenshots and comparison artifacts are evidence, not a substitute for inspecting behavior.

The following defects block visual completion:

- Unintended overlap.
- Clipped readable content.
- Incorrect artwork bounds, aspect behavior, or clipping.
- Controls that are inaccessible, unreachable, obscured, or too small to operate.

Correct blocking defects regardless of how many renders are required. After any correction that can affect layout, artwork, readable content, controls, or adaptation, render and reinspect the relevant final consumer and affected state. A prior capture cannot validate changed layout.

Once all completion gates pass, ordinary screen work gets a bounded cosmetic-refinement budget: perform one focused comparison pass, make one grouped set of non-blocking cosmetic corrections, and reinspect the result. Further iteration requires an explicitly dedicated visual-refinement task. Do not spend this budget chasing minor private-framework rendering, unavailable artwork, system typography rasterization, or status-bar differences.

If rendering or comparison tooling is unavailable, complete all code-level checks that remain possible and report the result as **visually unverified**. Do not imply visual completion from a successful build, preview compilation, or inspection of source alone; state what could not be rendered and which configurations remain unchecked.

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

Use this tooling for dedicated visual refinement and for the focused cosmetic pass in ordinary screen work. Correctness-driven reinspection is governed by the completion gates, not by a screenshot-count ceiling.

When artifacts are available, inspect `reference.png`, `actual.png`, `overlay-50.png`, and `diff.png`. Use current artifacts reflecting the intended final consumer and build.

Never resize or alter the canonical reference to make a comparison pass. State what visual verification was actually performed and any remaining unverified differences.

## 6. Repository hygiene and change discipline

### View files and previews

- Give every SwiftUI `View` its own file named after the type; do not collect independent components in umbrella files.
- Put private helper `View` types in appropriately named files and keep access as narrow as practical.
- Keep permitted computed view properties and small `@ViewBuilder` methods with their owner, following the example-screen composition rules above. File organization is not a reason to extract a new View.
- Small supporting enums/configuration types may remain beside their sole owner. Put shared models and configuration in separate files.
- Keep previews in the corresponding component file under `#if DEBUG`; multiple variations do not require separate files.
- Apply these conventions to example screens and app-shell views as well as Library components.
- Name previews `ComponentName — Variants`, adding `— Long Content`, `— Accessibility`, or `— Alternate Width` when those cases materially affect the component.

### Documentation and scope

When adding, extracting, or changing reusable presentation, update the Library index entry, public API documentation, and any component README in the same change. Document when to use it, caller responsibilities, supported variants/platforms, and demonstrated uses. Keep examples aligned with the current API. Add or update the applicable Element/Pattern documentation and regenerate the discovery registry when its source metadata changes; include semantic usage terms so agents can find the concept across domains.

Keep work focused on the current task. Do not redesign unrelated screens, refactor unrelated Library code, introduce large frameworks without need, or add third-party dependencies without strong justification.

Favor small, observable iterations. Preserve screen composition and content locally, generalize discovered UI concepts into Library with focused APIs, and report validation honestly.
