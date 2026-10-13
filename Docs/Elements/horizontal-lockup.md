---
id: horizontal-lockup
kind: element
category: content
intent:
  - browse
  - inform
  - act
content:
  - album
  - app
  - audiobook
  - book
  - episode
  - game
  - song
  - workout
platforms:
  ios: preferred
  ipados: preferred
  macos: unsupported
  tvos: unsupported
  watchos: unsupported
  visionos: unsupported
anatomy:
  - artwork
  - content
  - accessory
variants: []
avoidWhen:
  - content is primarily vertical or full-bleed
  - the relationship requires a card surface or overlay presentation
---

# Horizontal Lockup

## Purpose

Arrange leading artwork, flexible caller-supplied content, and an optional independent trailing accessory. `HorizontalLockup` is the shared horizontal content Element for categories such as Music, Podcasts, App Store, Fitness, Games, and Books.

## Public API

Callers provide `artworkSize`, artwork-to-content `spacing`, optional artwork/content `alignment`, optional `accessoryAlignment`, and `@ViewBuilder` content for each region. A scalar artwork size is a convenience for square artwork; `CGSize` supports rectangular artwork. The accessory closure may be omitted.

## Caller responsibilities

The caller owns content hierarchy, semantic typography, foreground styles, line limits, artwork shape and clipping, imagery effects, actions, accessibility labels, and whether artwork is decorative. Bottom controls such as episode playback belong inside the content builder. The accessory is reserved for an independent trailing action such as an overflow, download, or purchase control.

## Layout behavior

The Element applies only the artwork dimensions, artwork-to-content spacing, flexible content width, and the two vertical alignments. Content may contain any vertical or non-textual composition, wrap to multiple lines, and grow taller than the artwork. The accessory aligns independently against the combined artwork/content region and is omitted without requiring `EmptyView` at the call site.

`HorizontalLockup` does not impose a row height or assume a `List`, stack, shelf, or scroll container. Separators, outer padding, section margins, and collection spacing belong to the containing Pattern or example screen.

## Accessibility considerations

Semantic fonts and controls supplied by the caller scale naturally with Dynamic Type. Callers decide how content wraps and compose accessibility for their domain. The Element does not hide artwork or combine child accessibility elements because either behavior would incorrectly assume content semantics.

## Platform adaptation

The demonstrated implementation supports iOS and iPadOS. App Store, Fitness, Games, Books, and additional Apple platforms are future research targets rather than currently verified implementations.

## Examples / references

Apple Music demonstrates compact track and large attributed media lockups. Apple Podcasts demonstrates compact, featured playable, and recently played episode compositions. The component preview also records a radio/editorial configuration.
