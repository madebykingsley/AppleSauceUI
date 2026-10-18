---
id: episode-row
kind: element
category: content
intent:
  - browse
  - inform
  - act
content:
  - audio
  - episode
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
  - date-or-status
  - episode-title
  - supporting-metadata
  - media-badge
  - optional-playback-action
  - overflow-action
variants: []
avoidWhen:
  - the episode needs a rich card surface or summary
  - portrait artwork is the dominant presentation
  - no independent episode action is required
---

# Episode Row

## Purpose

Present a compact episode with leading artwork, a semantic metadata hierarchy, and an independent overflow action. The row can additionally expose playback when the caller supplies both a duration and a play action.

## Use when

Use `EpisodeRow` in multi-row shelves and lists where episodic items need more context and actions than a generic horizontal lockup should own. Use `EpisodeCard` when landscape artwork, a summary, and a card surface are part of the anatomy.

## Caller responsibilities

The caller maps domain values into the neutral date or status, title, supporting metadata, duration, badge meaning, and progress inputs. It supplies artwork, explicit specimen artwork geometry, and action closures. The caller’s collection Pattern owns separators and column relationships.

## Element responsibilities

The Element owns episode typography, Style Profile imagery treatment, Density metadata rhythm, decorative-artwork behavior, metadata accessibility composition, and the independent playback and overflow controls. When playback is omitted, duration and badge remain part of the metadata presentation.

## Accessibility considerations

Artwork is decorative. Available metadata and the badge’s accessible meaning are combined once in reading order. Playback and overflow remain separate accessible controls. Empty optional values are omitted from speech.

## Platform adaptation

The demonstrated implementation supports iOS and iPadOS. Other Apple platforms remain unsupported until researched and verified.

## Demonstrated uses

Podcasts Home uses the Element for missed, discovery, and recently played episodes. Podcasts New uses it for trending episodes. The Style Profile specimen demonstrates the same neutral anatomy outside podcast fixture models.

## Related components

- `EpisodeCard`
- `HorizontalLockup`
- `ColumnMediaShelf`
