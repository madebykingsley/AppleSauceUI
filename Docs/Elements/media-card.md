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
  - broadcast
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

The semantic initializer accepts artwork, optional eyebrow, required title, optional subtitle, optional metadata, and optional badge. MediaCard owns a default 1.6 artwork aspect ratio. Specialized compositions may use the lower-level metadata and actions slots when independent controls are required, may provide explicit content insets, and may select a demonstrated aspect ratio or fixed artwork height through `ArtworkContainerGeometry`, while retaining the same card container and explicit layout model. Supplied artwork owns content and scaling behavior, not displayed card geometry. Callers may select a semantic `ElementElevation`; the default remains `.standard`.

## Variants

`standard` places artwork, metadata, and optional independent actions in distinct vertical regions and is the appropriate variant for long supporting copy or action-heavy content. `overlay` layers concise metadata over artwork and applies an image scrim; it is not a text-heavy feature-card substitute. A requirement for full-bleed imagery together with long supporting copy or independent controls is an anatomy mismatch that needs a focused structural variant or different component, not extra spacing or blanket clipping. The caller selects the layout explicitly; a Style Profile never changes it.

## Style responsibilities

The Style Profile supplies content typography, primary and secondary foreground hierarchy, on-media foreground, surface, artwork and card shapes, image scrim, outline, the shadow for the requested semantic elevation, and symbol rendering. These are general semantic roles that other Elements may reuse; there are no MediaCard-specific profile tokens.

## Density responsibilities

Density supplies default content padding and metadata rhythm. It does not select layout, typography personality, color, surface, or imagery treatment. Standard density preserves the original 12-point card padding; explicit Recipe geometry may override the card insets without changing global density.

## Accessibility considerations

Text uses semantic styles and expands at accessibility Dynamic Type sizes. Artwork symbols are decorative, metadata remains readable in source order, and badges accept a distinct accessibility label when their compact text is insufficient. Interactive actions remain independent children when a Recipe supplies them.

## Geometry and imagery guarantees

The card owns its displayed artwork geometry, clipping, surface, and complete reported height. Standard-layout artwork is unmodified because text occupies a separate region. Overlay layout applies the semantic text-legibility treatment supplied by the active Style Profile; callers do not branch on profile identity. Supplied images own content and `fill`/`fit` scaling only.

## Composition example

```swift
MediaShelf(title: "Up Next", items: episodes, itemWidth: 249) { episode in
    EpisodeCard(date: episode.status, episodeTitle: episode.title, summary: episode.summary, duration: episode.duration, background: episode.background) {
        ArtworkImage(assetName: episode.artworkName, placeholderSymbol: "mic.fill", placeholderBackground: episode.fallback)
    }
}
```

Apple Podcasts Home demonstrates this semantic specialization; Music Radio demonstrates the lower-level standard card with caller-supplied metadata regions.

## Platform adaptation

iOS and iPadOS use the landscape card in shelves and vertical compositions. macOS supports the same anatomy with pointer conventions supplied by its Recipe. tvOS should adapt focus and action treatment. visionOS may adopt platform-native depth. watchOS is unsupported at this content density.

## Related patterns

- Media Shelf
- Media Grid

## Examples / references

The Style Profiles gallery renders identical MediaCard content under Editorial, Entertainment, and Neutral profiles and exposes Standard and Overlay as explicit layout choices. Podcast Recipes demonstrate the lower-level actions slot for playback and overflow controls.

The Music Radio screen uses the lower-level standard layout for live programming, with caller-supplied branded artwork and metadata regions and no elevation.
