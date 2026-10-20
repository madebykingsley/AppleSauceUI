---
id: episode-card
kind: element
category: content
intent:
  - feature
  - inform
  - act
content:
  - audio
  - episode
  - video
platforms:
  ios: preferred
  ipados: preferred
  macos: supported
  tvos: adapted
  watchos: unsupported
  visionos: supported
anatomy:
  - artwork
  - date-or-status
  - episode-title
  - summary
  - duration
  - media-badge
  - playback-action
  - overflow-action
variants: []
avoidWhen:
  - the content is not an episode
  - portrait artwork is the dominant hero presentation
  - dense scanning is more important than episode context and actions
---

# Episode Card

## Purpose

Present a playable audio or video episode through landscape artwork, a stable metadata hierarchy, and independent playback and overflow controls. `EpisodeCard` is a semantic Element built on the lower-level `MediaCard` container.

## Use when

Use an Episode Card when a podcast, television, or similar episodic item needs artwork, date or status, episode title, optional summary, duration, and direct actions in a shelf or vertical composition.

## Avoid when

Use `PosterLockup` for portrait, full-bleed hero artwork. Use `MediaCard` directly for rich cards whose content is not episodic, and use compact lockups when many items must be scanned quickly.

## Caller responsibilities

The caller maps domain data into the semantic string inputs, supplies artwork and its background style, and connects playback and overflow actions. The Element owns field order, typography, line limits, landscape artwork proportion, badge placement, card structure, and accessibility composition.

## Style and density responsibilities

The active Style Profile supplies semantic typography, including emphasized date or status metadata, on-media foreground hierarchy, shape, outline, shadow, and symbol treatment. Interface Density supplies content padding, metadata spacing, and the metadata-to-actions gap. Neither selects or rearranges episode fields.

## Accessibility considerations

Artwork is decorative. Episode metadata is combined in reading order, including the media badge's accessibility label (or its visible text as a fallback), while playback and overflow remain separate accessible controls. Cards without a badge omit that value rather than announcing an empty field. At normal Dynamic Type sizes, title and summary line limits bound the amount of copy without removing either field from layout. Accessibility sizes remove those limits so metadata, controls, the horizontal collection, and any following section grow and position intrinsically.

## Platform adaptation

iOS and iPadOS use the card directly in shelves. macOS supports the same anatomy with platform-appropriate pointer behavior supplied by the host. tvOS should adapt focus treatment, visionOS may adopt native depth, and watchOS is unsupported at this content density.

## Related components

- `MediaCard`
- `MediaShelf`
- `PosterLockup`

## Demonstrated uses

The Apple Podcasts Home and New examples use `EpisodeCard` for standard-width episode shelves, including audio and video-badged content.
