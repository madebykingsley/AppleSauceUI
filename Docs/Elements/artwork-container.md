---
id: artwork-container
kind: element
category: media
intent:
  - display
  - constrain
content:
  - artwork
  - image
  - accessory
platforms:
  ios: preferred
  ipados: preferred
  macos: unsupported
  tvos: unsupported
  watchos: unsupported
  visionos: unsupported
anatomy:
  - artwork
  - decoration
  - accessory
variants:
  - aspect-ratio
  - fixed-size
  - fixed-height
  - minimum-height
avoidWhen:
  - content is not visual media
  - intrinsic source dimensions should define layout
---

# Artwork Container

## Purpose

Provide a bounded artwork viewport whose displayed geometry does not depend on the dimensions of the supplied image. It is the shared implementation used by lockups, posters, editorial presentations, and media cards rather than a screen-level presentation on its own.

## Ownership

`ArtworkContainer` owns displayed size or aspect ratio, clipping, and the bounds available to decorations and accessories. Supplied artwork owns its content and scaling behavior, such as `fill` or `fit`. Replacing square artwork with landscape or portrait artwork must not change the container's intended geometry.

The neutral viewport is the only layout participant. Artwork, decorations, and accessories are overlaid into that viewport so their intrinsic sizes cannot alter it. Minimum-height geometry lets a text-owned feature presentation grow while its decorative artwork follows the resulting bounds. Clipping occurs at the artwork viewport boundary; callers must not add blanket clipping to a shelf or section to conceal overflow.

## Caller responsibilities

Choose geometry established by the consuming Element, provide the semantic clip shape, and supply artwork with an appropriate scaling behavior. Use an accessory only when it belongs within the artwork bounds.

Choose imagery treatment by content relationship, never by Style Profile identity. Use unmodified treatment when artwork stands alone or all readable text is outside its bounds. Use text-legibility treatment only when readable text overlays artwork; the active Style Profile supplies the actual scrim. This is a two-role semantic choice, not an open-ended effects configuration.

## Fixture substitution

When canonical artwork is unavailable, select a disclosed substitute that preserves the content role, broad composition, crop tolerance, and title placement of the reference. A portrait editorial poster is not interchangeable with a square album cover merely because both are images. If the bitmap contains a visible title, keep adjacent fixture text consistent with it. Record unavailable canonical assets rather than implying the substitute is original.

## Examples / references

The `ArtworkContainer — Mixed Source Dimensions` preview renders real square, landscape, and portrait bitmap fixtures together in a `MediaShelf` through `VideoLockup`.
