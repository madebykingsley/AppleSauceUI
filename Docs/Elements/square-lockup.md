---
id: square-lockup
kind: element
category: content
intent:
  - browse
  - identify
  - revisit
content:
  - album
  - playlist
  - show
  - collection
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - square-artwork
  - optional-artwork-accessory
  - title-below-artwork
  - optional-subtitle
  - optional-metadata
  - optional-badge
variants:
  - standard
  - ranked
  - library
avoidWhen:
  - title or supporting content belongs over the artwork
  - landscape artwork is the primary identity
  - independent playback or overflow actions are required
---

# Square Lockup

## Verified contract

`SquareLockup` presents square artwork followed by an external metadata hierarchy. It owns a 1:1 displayed viewport, clipping, outline, elevation, field order, standard line limits, and one combined accessibility label. Source bitmap proportions never change the square geometry, and artwork remains unmodified because no text is placed over it.

The caller supplies artwork content and scaling, neutral strings, optional badge meaning, and any artwork accessory accessibility label. The caller also chooses the surrounding `MediaShelf`, `MediaGrid`, or `RankedShelf` and owns navigation or selection interaction.

## Choosing a related component

Choose `SquareLockup` when identity is square artwork and the title belongs below it. Choose `VideoLockup` for landscape artwork with the same outside-title relationship. Choose `PosterLockup` when the title and supporting hierarchy belong inside portrait artwork. Choose `MediaCard` when content needs a surface, richer hierarchy, or independent actions.

## Demonstrated compositions

```swift
MediaShelf(title: "Recently Played", items: albums, itemWidth: 161) { album in
    SquareLockup(title: album.title, subtitle: album.artist) {
        ArtworkImage(assetName: album.artworkName, placeholderSymbol: "music.note", placeholderBackground: album.fallback)
    }
}
```

Apple Music Home and New demonstrate shelf composition; Apple Podcasts Home demonstrates show artwork with external title and supporting metadata.
