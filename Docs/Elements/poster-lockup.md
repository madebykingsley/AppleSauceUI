---
id: poster-lockup
kind: element
category: content
intent:
  - feature
  - recommend
content:
  - artwork
  - playlist
  - collection
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - portrait-artwork
  - title-over-artwork
  - optional-eyebrow
  - supporting-text
variants:
  - semantic-elevation
avoidWhen:
  - title belongs outside the artwork
  - long-form supporting copy or independent actions are required
  - landscape artwork is required
---

# Poster Lockup

## Verified contract

`PosterLockup` is a portrait, full-bleed feature whose title sits at the top of the artwork and whose eyebrow and supporting text sit at the bottom. It owns its minimum displayed height, text hierarchy, clipping, outline, elevation, accessibility composition, and the text-legibility artwork treatment. At accessibility sizes, text can increase the reported card height and the decorative artwork follows those bounds.

The caller supplies the evidenced minimum height, artwork content and scaling, strings, and surrounding collection or screen interaction. The supplied bitmap cannot determine poster geometry. Independent buttons, long-form copy, landscape layout, and arbitrary overlay slots are outside this anatomy.

## Choosing a related component

Choose `PosterLockup` for text inside portrait artwork. Choose `EditorialHero` when eyebrow and title sit above landscape artwork. Choose `SquareLockup` when title and metadata sit below square artwork. Choose `MediaCard.standard` for long copy or independent actions; use `MediaCard.overlay` only for concise metadata over landscape artwork.

Apple Music Home demonstrates `PosterLockup` in the “Top Picks for You” shelf.
