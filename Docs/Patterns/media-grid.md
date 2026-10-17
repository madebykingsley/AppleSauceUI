---
id: media-grid
kind: pattern
category: content
intent:
  - browse
  - scan
  - revisit
content:
  - album
  - playlist
  - book
  - video
  - game
  - category
  - channel
platforms:
  ios: preferred
  ipados: preferred
  macos: preferred
  tvos: adapted
  watchos: unsupported
  visionos: supported
elements:
  - media-lockup
  - section-header
variants:
  - artwork
  - poster
  - landscape
  - ranked
avoidWhen:
  - the first few recommendations matter more than collection breadth
  - content must be compared across many attributes
  - primary interaction is editing
---

# Media Grid

## Purpose

Present a vertically browsable media collection with consistent columns and an optional heading. The grid defines collection structure and behavior; its environment supplies visual language and density.

## Use when

Use a media grid when people benefit from scanning or revisiting a broader collection and vertical space is appropriate. It works well for libraries, recently added content, and category results.

## Avoid when

Avoid it when a short recommendation shelf better communicates priority, when many attributes must be compared in rows or columns, or when editing is the primary task.

## Anatomy

A grid contains an optional section header followed by a lazy vertical grid. Omitting `title` renders the collection without a header or reserved title space. Each identifiable item is rendered by a caller-supplied Element or Recipe. The pattern owns column count, column gaps, row gaps, and content margins.

## Behavior

The collection participates in its surrounding vertical scroll container and lazily creates rows. Item actions remain caller-owned. Stable item identity preserves state and enables correct collection updates.

## Variants

Artwork, poster, landscape, ranked, and elevated-tile presentations describe the supplied item rather than separate grid implementations. Column count and explicit geometry may be adapted by the containing screen composition or platform. Compact category and channel grids use the same collection behavior and do not require a separate grid Pattern.

## Content requirements

Items must have stable, unique identity. Each supplied item presentation should have a predictable aspect ratio and accessible semantic label. Titles should remain scannable at the chosen column width.

## Accessibility considerations

Use semantic text styles and allow lockup metadata to expand at accessibility sizes. A Recipe may reduce column count when larger content sizes make the default count unsuitable. Do not encode meaning only through profile color or artwork.

## Platform adaptation

iOS and iPadOS adapt column count to available width. macOS can use additional columns while retaining readable item widths. tvOS should adapt focus movement and prominence. visionOS may retain the grid with platform-native depth and input. watchOS is unsupported.

## Elements used

- Section Header
- Media lockup chosen for the content shape

## Related patterns

- Media Shelf
- Ranked Shelf
- Column Media Shelf

## Examples / references

The Style Profiles example renders identical media data and one `MediaGrid` structure under Editorial, Entertainment, and Neutral profiles. The Music and Podcasts library examples supply app-specific content to the same grid pattern.

The Music Radio screen demonstrates a three-column grid of `ElevatedTile` content. The MediaGrid preview uses destination content to demonstrate the same relationship outside a media domain.
