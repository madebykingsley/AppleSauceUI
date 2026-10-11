# AppleSauce responsibility boundaries

Use these boundaries when selecting, generating, or reviewing AppleSauce UI. A layer may consume decisions from another layer, but it must not silently take ownership of them.

## Pattern owns

- Arrangement of Elements
- Collection behavior and stable identity
- Navigation relationships within the pattern
- Responsive collection structure

## Element owns

- Semantic content anatomy
- Element-specific structural variants
- Accessibility composition for that anatomy

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

## Recipe owns

- Product-specific composition of Patterns and Elements
- Mapping domain models into semantic presentation inputs
- Explicit product geometry that overrides density defaults
- App-shell state and navigation destinations

## Platform adaptation owns

- Platform interaction conventions
- Navigation transformation
- Focus, hover, pointer, remote, and spatial-input behavior
- Platform-specific structural changes
