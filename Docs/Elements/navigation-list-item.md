---
id: navigation-list-item
kind: element
category: navigation
intent:
  - navigate
  - browse
  - discover
content:
  - destination
  - category
  - quick-link
platforms:
  ios: preferred
  ipados: preferred
  macos: unsupported
  tvos: unsupported
  watchos: unsupported
  visionos: unsupported
anatomy:
  - title
  - optional-disclosure-indicator
  - optional-separator
variants:
  - capsule
  - plain
avoidWhen:
  - the destination requires supporting metadata or artwork
  - the content is not navigational
  - a native List row already provides the required presentation
---

# Navigation List Item

## Purpose

Present a single text destination with the compact hierarchy used by browse and quick-link sections. The Element owns the row presentation while the caller owns its native control and destination.

## Use when

Use `NavigationListItem` as the label of a `NavigationLink` or `Button` when a screen presents a short list of tint-colored text destinations outside a native `List`.

Choose `.capsule` for a separated rounded surface with a trailing disclosure indicator. Choose `.plain` for a divided text row without a disclosure indicator.

## Avoid when

Prefer a native `List` row when the surrounding screen already uses `List` or `Form`. Use a richer Element when a destination needs artwork, supporting metadata, badges, or independent controls.

## Anatomy

Both variants contain a leading title. Capsule items add a decorative trailing chevron and adaptive system-fill background. Plain items own their bottom separator.

## Style and density responsibilities

The title uses the semantic body text style and inherits the enclosing app tint. The capsule uses the adaptive quaternary system fill rather than a fixed light-mode color. Density supplies horizontal padding and title-to-chevron spacing; the 56-point capsule height, 52-point plain height, and 12-point capsule radius are reference-established minimum geometry.

## Accessibility considerations

The title remains the accessible label supplied by the enclosing native control. The decorative capsule chevron is hidden from assistive technologies. Minimum heights may expand for wrapped text and accessibility Dynamic Type sizes.

## Platform adaptation

The current variants are demonstrated on iOS and iPadOS. Other platforms remain unsupported until references establish appropriate native presentation.

## Examples / references

Apple Music New and Radio use capsule items for More to Explore. Apple Podcasts New uses plain items for Podcasts Quick Links. Neutral previews demonstrate that both variants are independent of those domains.
