---
id: media-shelf
kind: pattern
category: content
intent:
  - browse
  - discover
  - recommend
content:
  - album
  - playlist
  - book
  - video
  - game
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
elements:
  - media-lockup
  - section-header
variants:
  - artwork
  - poster
  - landscape
  - ranked
  - editorial
avoidWhen:
  - content must be compared across many attributes
  - primary interaction is editing
---

# Media Shelf

## Purpose

Present a titled, horizontally browsable collection of media while preserving stable item identity and native scrolling behavior. The shelf defines structure and behavior; its environment supplies visual language and density.

## Use when

Use a media shelf for browse, discovery, or recommendation flows where artwork and a compact semantic label help people recognize items quickly.

## Avoid when

Avoid it when people must compare many attributes across items, when editing is the primary task, or when the complete collection must remain visible without horizontal navigation.

## Anatomy

A shelf uses native `Section` structure with an optional custom visual header and one horizontal collection. Each identifiable item is rendered by a caller-supplied Element or Recipe, such as a square lockup. The pattern owns margins, inter-item spacing, alignment, and scroll targeting.

## Behavior

Items scroll horizontally with hidden indicators. View-aligned scrolling is the default; continuous scrolling is available for content that should not snap. An actionable header remains a separate control from item actions.

## Variants

Artwork, poster, landscape, ranked, and editorial variants describe the supplied item presentation—not separate shelf implementations. A style profile may change typography, surfaces, imagery treatment, and chrome without changing the variant or collection behavior.

## Content requirements

Items must have stable, unique identity. Callers provide the item width because it describes genuine content geometry and preserves reference comparison. A future demonstrated use may add adaptive `containerRelativeFrame` sizing, but fixed and adaptive sizing should remain distinct API choices. Titles should be concise, and artwork must carry an accessible semantic label through its containing lockup.

## Accessibility considerations

Use semantic text styles so Dynamic Type continues to scale. Keep item identity stable so focus and scroll position survive updates. Header actions and item actions must remain independently discoverable. Do not encode meaning only through profile color or imagery treatment.

## Platform adaptation

iOS and iPadOS prefer touch-driven horizontal shelves. macOS supports the pattern with pointer and trackpad scrolling. tvOS should adapt focus movement and item prominence. visionOS can retain the structure with platform-native depth and input. watchOS is unsupported because the horizontal multi-item presentation is not appropriate at that scale.

## Elements used

- Section Header
- Media lockup chosen for the content shape

## Related patterns

- Ranked Shelf
- Media Grid
- Column Media Shelf

## Examples / references

The Style Profiles example renders the same media data and `MediaShelf` structure under Editorial, Entertainment, and Neutral profiles. Existing Music and Podcasts examples demonstrate app-specific Recipes supplying content to the same pattern.
