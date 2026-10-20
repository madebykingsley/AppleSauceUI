---
id: editorial-hero
kind: element
category: content
intent:
  - feature
  - inform
content:
  - editorial
  - artwork
  - promotion
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: unsupported
  watchos: unsupported
  visionos: supported
anatomy:
  - eyebrow-above-artwork
  - title-above-artwork
  - landscape-artwork
variants:
  - semantic-elevation
avoidWhen:
  - title belongs over the artwork
  - independent actions or in-artwork metadata are required
  - portrait artwork is required
---

# Editorial Hero

## Verified contract

`EditorialHero` places an eyebrow and prominent title outside and above a 1.5:1 landscape artwork viewport. It owns title hierarchy, artwork geometry, clipping, outline, elevation, and combined accessibility order. Because text is external, artwork is displayed unmodified and cannot determine title layout.

The caller supplies concise editorial strings, artwork content and scaling, and any surrounding navigation interaction. It must not place controls or metadata inside the artwork. A design that needs full-bleed text or actions has different anatomy and should use `PosterLockup`, `MediaCard`, or a focused new structural variant.

```swift
EditorialHero(eyebrow: story.kicker, title: story.headline) {
    ArtworkImage(assetName: story.artworkName, placeholderSymbol: "photo", placeholderBackground: story.fallback)
}
```

Apple Music New demonstrates horizontally scrolling editorial heroes with title content outside the supplied artwork.
