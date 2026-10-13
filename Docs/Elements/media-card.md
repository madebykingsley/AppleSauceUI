---
id: media-card
kind: element
category: content
intent:
  - feature
  - inform
  - recommend
content:
  - artwork
  - audio
  - book
  - episode
  - game
  - video
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - artwork
  - eyebrow
  - title
  - subtitle
  - metadata
  - badge
variants:
  - landscape-standard
  - landscape-overlay
avoidWhen:
  - content is recognized primarily through compact square artwork
  - many items must be scanned at once
  - content requires tabular comparison
---

# Media Card

## Purpose

Present one content-rich media item through landscape artwork and a stable semantic metadata hierarchy. The Element owns its anatomy and explicit layout; a Style Profile changes presentation without adding, removing, or rearranging fields.

## Use when

Use a Media Card when artwork, title, and supporting context need more prominence than a compact lockup provides. It fits featured episodes, documentaries, editorial recommendations, trailers, and similarly rich media.

## Avoid when

Avoid it for dense libraries dominated by square artwork, broad collections that need rapid scanning, or content that must be compared across many attributes.

## Anatomy

The semantic initializer accepts artwork, optional eyebrow, required title, optional subtitle, optional metadata, and optional badge. Specialized Recipes may use the lower-level metadata and actions slots when independent controls are required, and may provide explicit content insets when reference geometry differs from density defaults, while retaining the same card container and explicit layout model.

## Variants

`standard` places artwork and metadata in distinct vertical regions. `overlay` layers the same metadata hierarchy over artwork and applies an image scrim. The caller selects the layout explicitly; a Style Profile never changes it.

## Style responsibilities

The Style Profile supplies content typography, primary and secondary foreground hierarchy, on-media foreground, surface, artwork and card shapes, image scrim, outline, shadow, and symbol rendering. These are general semantic roles that other Elements may reuse; there are no MediaCard-specific profile tokens.

## Density responsibilities

Density supplies default content padding and metadata rhythm. It does not select layout, typography personality, color, surface, or imagery treatment. Standard density preserves the original 12-point card padding; explicit Recipe geometry may override the card insets without changing global density.

## Accessibility considerations

Text uses semantic styles and expands at accessibility Dynamic Type sizes. Artwork symbols are decorative, metadata remains readable in source order, and badges accept a distinct accessibility label when their compact text is insufficient. Interactive actions remain independent children when a Recipe supplies them.

## Platform adaptation

iOS and iPadOS use the landscape card in shelves and vertical compositions. macOS supports the same anatomy with pointer conventions supplied by its Recipe. tvOS should adapt focus and action treatment. visionOS may adopt platform-native depth. watchOS is unsupported at this content density.

## Related patterns

- Media Shelf
- Media Grid

## Examples / references

The Style Profiles gallery renders identical MediaCard content under Editorial, Entertainment, and Neutral profiles and exposes Standard and Overlay as explicit layout choices. Podcast Recipes demonstrate the lower-level actions slot for playback and overflow controls.
