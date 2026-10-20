---
id: video-lockup
kind: element
category: content
intent:
  - inform
  - browse
content:
  - video
platforms:
  ios: preferred
  ipados: preferred
  macos: unsupported
  tvos: unsupported
  watchos: unsupported
  visionos: unsupported
anatomy:
  - artwork
  - title
  - subtitle
  - metadata
variants: []
avoidWhen:
  - content needs independent playback or overflow controls
  - content needs multiple rich regions or overlay presentation
---

# Video Lockup

## Purpose

Present lightweight video content through landscape artwork and a compact semantic metadata hierarchy. The Element is designed as an item inside a collection rather than as a self-contained interactive card.

## Use when

Use `VideoLockup` when a shelf or grid needs scannable landscape video artwork, a required title, and optional creator/subtitle or metadata. Music video and interview shelves currently demonstrate this use on iOS and iPadOS.

## Avoid when

Use `MediaCard` instead when content needs a surface, multiple content regions, an overlay layout, playback controls, overflow controls, or other independent actions. `VideoLockup` does not own interaction; callers provide navigation or buttons around it when required.

## Caller responsibilities

The caller supplies neutral title, subtitle, metadata, and artwork content, chooses any reference-specific artwork aspect ratio, and places the Element inside an appropriate Pattern. `VideoLockup` owns that displayed aspect ratio and clipping; the supplied artwork owns only its content and scaling behavior. Source bitmap dimensions do not change lockup geometry. Domain models remain outside the Library.

## Style and density responsibilities

The active Style Profile supplies item typography, foreground hierarchy, artwork treatment, shape, and shadow. Interface Density supplies the spacing between artwork and metadata. The video artwork aspect ratio remains content geometry rather than a density decision.

Artwork is unmodified because all readable metadata sits outside the image. If a design requires a scrim for overlaid text, it is not this anatomy; choose `MediaCard.overlay` or another verified overlay component.

## Accessibility considerations

Artwork is decorative. The Element exposes title, subtitle, and metadata as one ordered accessibility label, and text can expand beyond its standard single-line presentation at accessibility Dynamic Type sizes.

## Platform adaptation

The demonstrated implementation supports iOS and iPadOS. Other platforms remain undocumented until a concrete specimen validates their presentation and interaction conventions.

## Related components

- Media Shelf
- Media Grid
- Media Card

## Examples / references

Apple Music New demonstrates `VideoLockup` for interview and music-video shelves.

```swift
MediaShelf(title: "Music Videos", items: videos, itemWidth: 249) { video in
    VideoLockup(title: video.title, subtitle: video.artist) {
        ArtworkImage(assetName: video.artworkName, placeholderSymbol: "video", placeholderBackground: video.fallback)
    }
}
```
