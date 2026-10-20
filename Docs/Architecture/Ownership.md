# AppleSauce responsibility boundaries

Use these boundaries when selecting, generating, or reviewing AppleSauce UI. A layer may consume decisions from another layer, but it must not silently take ownership of them.

## Pattern owns

- Arrangement of Elements
- Collection behavior and stable identity
- Navigation relationships within the pattern
- Responsive collection structure
- Collection-level geometry such as item placement, gaps, margins, and scrolling

## Element owns

- Semantic content anatomy
- Element-specific structural variants
- Accessibility composition for that anatomy
- Element-level geometry such as aspect behavior, clipping, internal layout, and intrinsic sizing

## Style Profile owns

- Typography and foreground hierarchy
- Color, surfaces, and materials
- Shape, imagery, scrims, outlines, and shadows
- Symbol rendering and motion character

A Style Profile does not add, remove, reorder, or navigate content. If content placement changes, expose an Element variant or platform adaptation explicitly.

## Density owns

- Spacing rhythm and internal padding
- Content margins and collection gaps
- Compactness of metadata and controls where appropriate

Density does not encode brand styling or select structural variants.

## Examples own

- Product-specific composition of Patterns and Elements
- Mapping domain models into semantic presentation inputs
- Explicit product geometry that overrides density defaults
- App-shell state and navigation destinations
- Fixtures, supplied assets, branding content, and destination wiring

Examples do not own reusable visual language, component anatomy, or collection behavior. A reusable concept discovered in one specimen is still generalized into Library unless doing so would harm semantic clarity or native behavior and the exception is documented.

## Reuse decisions

Compare anatomy, geometry ownership, interaction, and adaptive behavior before reusing or extending a component. Reuse requires compatible responsibility across those dimensions, not merely visual similarity.

Component reuse shares semantic presentation and behavior. Asset reuse shares supplied artwork, symbols, colors, or other content resources. The same asset may appear in components with different anatomy or behavior without making those components one abstraction.

## Recipe guidance

Recipe is reserved for future agent-facing composition guidance. It is not a SwiftUI ownership layer, factory namespace, or screen abstraction. Concrete screen composition remains in Examples.

## Platform adaptation owns

- Platform interaction conventions
- Navigation transformation
- Focus, hover, pointer, remote, and spatial-input behavior
- Platform-specific structural changes

## Screen-driven validation

Follow this sequence: inspect the reference and existing components; prove layout with actual content; generalize reusable concepts; then render and verify the final consumer. Verification before extraction does not validate the final composition.

Unintended overlap, clipped readable content, incorrect artwork bounds, and inaccessible or unreachable controls block visual completion. Reinspect after corrections that can affect these conditions. Cosmetic refinement is bounded after correctness gates pass; correctness reinspection is not limited by a screenshot count. When rendering is unavailable, report the result as **visually unverified** and identify what remains unchecked.
