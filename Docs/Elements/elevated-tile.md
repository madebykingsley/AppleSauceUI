---
id: elevated-tile
kind: element
category: content
intent:
  - browse
  - discover
  - select
content:
  - category
  - channel
  - destination
  - service
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - primary-content
  - optional-footer
variants:
  - semantic-elevation
avoidWhen:
  - metadata outside the surface is required
  - landscape artwork is the dominant presentation
  - a native list row communicates the relationship more clearly
---

# Elevated Tile

## Purpose

Present supplied content on a compact square surface whose shape, surface, outline, and elevation follow the active Style Profile. The tile owns the reusable surface treatment while callers own domain artwork, branding, and actions.

## Use when

Use an elevated tile for compact browsing choices such as channels, categories, destinations, or services where the supplied artwork and optional footer belong on one raised square surface. Compose it inside a native `Button` or `NavigationLink` when it is interactive.

## Avoid when

Use `SquareLockup` when title or metadata belongs outside the artwork. Use `MediaCard` for content-rich landscape presentations. Prefer a native list row when the content is primarily textual or hierarchical.

## Anatomy

The primary content fills the available space. An optional footer follows it inside the same surface. Callers provide both regions and their semantic content; the Element owns their relationship, square geometry, clipping, outline, shadow, and combined accessibility container.

## Style and density responsibilities

The Style Profile supplies the surface, card shape, outline, and shadow selected through `ElementElevation`. Density supplies internal padding and the gap between primary content and footer. Brand colors, logos, and strings remain caller content.

## Accessibility considerations

The tile combines its supplied children. The enclosing native control should provide a concise label when artwork or a compact footer does not produce an adequate spoken name.

## Platform adaptation

iOS and iPadOS use the tile in compact browsing grids. macOS and visionOS retain the surface while adopting native pointer or spatial interaction from the enclosing control. tvOS should adapt focus treatment. watchOS is unsupported at this density.

## Related patterns and elements

- Media Grid
- Media Shelf
- Square Lockup
- Media Card

## Examples / references

The Music Radio screen supplies branded channel artwork to Elevated Tiles in a three-column Media Grid. The Element preview uses destination content to demonstrate that the surface is independent of Radio.
