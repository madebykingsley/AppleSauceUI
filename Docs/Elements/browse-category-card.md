---
id: browse-category-card
kind: element
category: content
intent:
  - browse
  - discover
  - select
content:
  - category
  - genre
  - topic
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - title
  - decorative-symbol
variants:
  - landscape
  - portrait
avoidWhen:
  - metadata outside the surface is required
  - artwork is the primary identity
  - a native list row communicates the relationship more clearly
---

# Browse Category Card

## Purpose

Present a category, genre, or topic as a compact colored card with a semantic title and decorative symbol. The card owns its hierarchy, proportions, clipping, and accessibility composition; callers own the label, symbol, background, action, and collection arrangement.

## Layouts

Use `.landscape` in compact two-column browsing grids such as Music and Podcasts search. Use `.portrait` for tall cards in denser three-column browsing grids, such as a TV category browser. The layout choice controls card proportions and symbol scale; `MediaGrid` or another native collection remains responsible for column count and spacing.

Both layouts use a 14-point continuous corner radius and a body-sized semibold title. At accessibility Dynamic Type sizes, the card relaxes its fixed aspect ratio so longer localized titles can grow without clipping.

## Use and ownership

Compose the card inside a native `Button` or `NavigationLink`. Supply a high-contrast background and a meaningful title. The symbol is decorative and hidden from assistive technologies; the title supplies the spoken identity.

Use `ElevatedTile` when content and an optional footer belong on a square raised surface. Use `SquareLockup` when metadata belongs outside square artwork, and use `MediaCard` for content-rich landscape media.
