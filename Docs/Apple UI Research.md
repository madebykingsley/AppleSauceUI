# AppleSauce: Research into Apple's Internal UI Architecture

> The focused research summary and adopted AppleSauce naming decisions now live in [Research/apple-ui-internals.md](Research/apple-ui-internals.md). This document preserves the detailed exploratory evidence.

**Status:** Exploratory research  
**Research date:** October 10, 2026  
**Platform:** iOS 27.0 Simulator (24A434)  
**Development environment:** Xcode 27.0 (27A266a)  
**Primary subjects:** MusicUI, AppStoreComponents  
**Purpose:** Inform AppleSauce's naming conventions, component taxonomy, and architectural design.

## 1. Executive summary

Binary inspection of Apple's first-party iOS frameworks provides evidence that Apple uses a recurring concept called a **Lockup** to represent a composed content presentation.

This terminology appears independently in the Music and App Store frameworks.

The investigation also revealed evidence of distinct layers for component models, rendering views, presentation variants, layout, and context-dependent styling.

These findings broadly support AppleSauce's proposed architecture:

```text
Foundations
    ↓
Elements
    ↓
Patterns
    ↓
Recipes
```

However, the investigation does not establish that Apple itself uses this four-level taxonomy.

### Principal findings

- `MusicUI.framework` exposes an extensive collection of Swift component models, including `SquareLockup`, `PosterLockup`, `CircleLockup`, `HorizontalLockup`, and `TrackLockup`.
- Several MusicUI lockups conform to `JetEngine.ComponentModel`.
- MusicUI contains SwiftUI rendering implementations, including identifiable lockup views and collection layouts.
- `AppStoreComponents.framework` independently uses `Lockup` terminology.
- AppStoreComponents separates lockup content, presentation, styling, display context, and sizing into identifiable abstractions.
- Both frameworks reference Apple's private `JetEngine` infrastructure.
- Multiple internal lockup types expose explicit styling or presentation variants.

**Primary recommendation:** Consider `Lockup` as AppleSauce's terminology for self-contained content presentations, while retaining `Shelf`, `Grid`, and similar terms for patterns that organize multiple elements.

This is a recommendation, not a finalized architectural decision.

---

## 2. Research methodology

The investigation examined compiled binaries from Apple's iOS 27 Simulator runtime.

The runtime was located at:

```text
/Library/Developer/CoreSimulator/Volumes/iOS_24A434/
```

The relevant binaries originated from:

```text
System/Library/PrivateFrameworks/MusicUI.framework/
```

and:

```text
System/Library/PrivateFrameworks/AppStoreComponents.framework/
```

### Tools

- `nm` — Mach-O symbol inspection
- `swift-demangle` — Swift symbol demangling
- `otool` — Mach-O structure and dependency inspection
- `file` — Binary identification
- `grep` — Symbol filtering
- `ipsw` — dyld shared-cache inspection and extraction

### Analysis limitations

Compiled symbols can reveal type names, protocol conformances, method signatures, and implementation relationships.

They cannot reliably establish:

- The precise visual appearance of a component.
- Which component renders a particular screenshot.
- The original source-code architecture.
- Whether components are reused across applications.
- Exact spacing, sizing, typography, or interaction behavior.
- Whether a private implementation represents Apple's preferred contemporary approach.

Throughout this document, **observed** means directly supported by recovered binary information. **Inferred** means a plausible architectural interpretation that requires further validation.

---

## 3. MusicUI.framework

### Binary information

| Property | Result |
|---|---|
| Framework | MusicUI |
| Platform | iOS 27.0 Simulator |
| Architecture | ARM64 |
| Approximate binary size | 16 MB |
| Symbol entries | 82,890 |
| Entries matching initial UI search | 7,516 |
| Swift type metadata | Present |

The symbol counts are raw entries, not counts of unique components.

### 3.1 Lockup families

The following type names were recovered.

**Basic presentations**

```swift
ListLockup
BrickLockup
TrackLockup
CircleLockup
PosterLockup
SquareLockup
HorizontalLockup
```

**Specialized presentations**

```swift
SuperHeroLockup
FlowcaseLockup
SplitPosterLockup
SocialCardLockup
EmptyStateLockup
TopSearchLockup
RecentSearchLockup
```

**Music-specific presentations**

```swift
AlbumTrackLockup
PlaylistTrackLockup
TrackShelfLockup
ArtistLatestReleaseLockup
LiveRadioGridLockup
LiveRadioPosterLockup
```

**Detail headers**

```swift
AlbumDetailHeaderLockup
PlaylistDetailHeaderLockup
ConcertDetailHeaderLockup
ArtistConcertsHeaderLockup
TVMovieDetailHeaderLockup
ContainerDetailHeaderLockup
```

**Adaptive presentations**

```swift
AdaptiveHorizontalCircleLockup
AdaptiveHorizontalSquareLockup
```

These are observed type names. Their precise rendering behavior has not been verified.

### 3.2 Component models

Several recovered symbols establish protocol conformances resembling:

```swift
PosterLockup: JetEngine.ComponentModel
SquareLockup: JetEngine.ComponentModel
CircleLockup: JetEngine.ComponentModel
```

Other symbols reference:

```swift
ItemViewRegistering
Mappable
MappableItem
AutomationAccessible
```

**Inference:** MusicUI appears to have a model-driven component architecture in which presentation models are associated with rendering implementations.

This does not imply that every model has a unique renderer.

### 3.3 Rendering views

Recovered symbols include references to:

```swift
LegacyPosterLockupView
LiveRadioPosterLockupView
ItemCollectionGridView
SectionHeaderView
```

The compiled SwiftUI signatures also reference standard SwiftUI primitives, including:

```swift
VStack
LazyHGrid
LazyVGrid
ScrollView
ModifiedContent
```

**Inference:** At least part of MusicUI uses SwiftUI to render components described by its internal component models.

### 3.4 Presentation variants

`PosterLockup` exposes nested types including:

```swift
PosterLockup.Kind
PosterLockup.Style
PosterLockup.Kind.TallArtwork
PosterLockup.Kind.SquareArtwork
PosterLockup.Kind.CenteredArtwork
```

Similarly:

```swift
SquareLockup.Style
SquareLockup.TextStyle
SquareLockup.OverlayStyle
```

These are recovered type identifiers, not verified complete API definitions.

**Architectural implication:** Presentation variants appear to be encoded explicitly, rather than requiring a separate top-level component for every visual difference.

This supports AppleSauce's preference for a limited number of semantic component families with intentional variants.

---

## 4. AppStoreComponents.framework

### Binary information

| Property | Result |
|---|---|
| Framework | AppStoreComponents |
| Source | iOS 27.0 dyld shared cache |
| Architecture | ARM64 |
| Extracted symbol entries | 8,070 |
| Swift type metadata | Present |
| Objective-C metadata | Present |

The framework was extracted from:

```text
System/Library/Caches/com.apple.dyld/
dyld_sim_shared_cache_arm64
```

using `ipsw`.

### 4.1 Core Lockup architecture

Recovered types include:

```swift
ASCLockup
ASCLockupView
ASCLockupContentView
ASCLockupPresenter
ASCLockupMediaPresenter
ASCLockupTheme
ASCDefaultLockupTheme
ASCStaticLockupTheme
ASCLockupDisplayContext
ASCLockupProductDetails
```

These suggest the following conceptual responsibilities:

| Responsibility | Observed type |
|---|---|
| Content representation | `ASCLockup` |
| Rendering | `ASCLockupView` |
| Content layout | `ASCLockupContentView` |
| Presentation coordination | `ASCLockupPresenter` |
| Styling | `ASCLockupTheme` |
| Display context | `ASCLockupDisplayContext` |

The responsibilities are inferred from names and method signatures.

### 4.2 Explicit size variants

Recovered identifiers include:

```text
Mini
Small
Medium
Large
SmallOfferButton
MediumOfferButton
LargeAppAd
LargeAppShowcase
```

These appear in identifiers associated with `ASCLockupViewSize`.

Methods include:

```swift
preferredIconSizeForSize
preferredLabelAlignmentForSize
numberOfLinesInTitleForSize
numberOfLinesInSubtitleForSize
```

**Inference:** AppStoreComponents adapts artwork, typography, and metadata according to presentation size.

The exact size constants and layout rules remain unknown.

### 4.3 Context-dependent presentation

Recovered identifiers include contexts associated with:

```text
Standard
Overlay
Wallet
Watch
Springboard
GameCenter
WebBrowser
AppStoreInstall
```

Platform identifiers include:

```text
IOS
MacOS
TvOS
VisionOS
WatchOS
```

This supports the existence of context and platform concepts within the framework.

It does not establish that every context is supported on every platform.

### 4.4 Shared infrastructure

AppStoreComponents depends on:

```text
JetEngine.framework
JetUI.framework
SwiftUI.framework
UIKit.framework
```

MusicUI also references `JetEngine`.

**Finding:** Both frameworks use or reference shared private Apple infrastructure.

**Unverified:** Whether they share concrete UI components, registration mechanisms, or rendering implementations.

---

## 5. Implications for AppleSauce

### 5.1 Adopt semantic presentation terminology

The strongest naming insight concerns `Lockup`.

Across two Apple frameworks, it refers to abstractions associated with composed content presentations.

For AppleSauce, a useful working definition would be:

> A Lockup is a self-contained presentation of a content entity, typically combining artwork, text, metadata, and optional actions.

Examples:

```swift
SquareLockup(...)
PosterLockup(...)
HorizontalLockup(...)
TrackLockup(...)
```

These would be AppleSauce implementations, not wrappers around Apple's private APIs.

### 5.2 Preserve the distinction between Elements and Patterns

A proposed architecture:

```text
AppleSauce/
├── Foundations/
│   ├── Layout/
│   ├── Typography/
│   ├── Materials/
│   └── Motion/
│
├── Elements/
│   ├── Lockups/
│   │   ├── SquareLockup.swift
│   │   ├── PosterLockup.swift
│   │   ├── CircleLockup.swift
│   │   ├── HorizontalLockup.swift
│   │   └── TrackLockup.swift
│   └── Artwork/
│
├── Patterns/
│   ├── MediaShelf/
│   ├── MediaGrid/
│   ├── RankedShelf/
│   └── EditorialFeature/
│
└── Recipes/
    ├── MusicHome/
    ├── TVHome/
    └── AppStoreHome/
```

This structure remains provisional.

The central architectural distinction is:

| Concept | Responsibility |
|---|---|
| Foundation | Shared visual or behavioral principle |
| Element | Independent presentation of an entity |
| Pattern | Composition, layout, and interaction of elements |
| Recipe | Complete screen composed from patterns |

### 5.3 Avoid overfitting Apple's implementation

Do not automatically reproduce Apple's private architecture.

For example, AppStoreComponents separates presentation, context, size, styling, data, and coordination into numerous classes.

That degree of complexity is not necessarily appropriate for a small SwiftUI library.

AppleSauce should expose simple semantic APIs and encapsulate adaptation internally where justified.

### 5.4 Prioritize patterns over individual components

The research reinforces an existing AppleSauce hypothesis:

**Individual visual elements are useful, but their relationships and adaptive behavior are often more valuable.**

For example:

```swift
MediaShelf(items: albums) { album in
    SquareLockup(
        artwork: album.artwork,
        title: album.title,
        subtitle: album.artist
    )
}
```

The `SquareLockup` defines an individual item's presentation.

The `MediaShelf` determines how those items are arranged and interact.

AppleSauce's distinctive value should come from implementing both appropriately across Apple platforms.

---

## 6. Open questions

### Naming and taxonomy

1. Should `Lockup` replace `MediaCard` in AppleSauce's public API?
2. Is `Lockup` sufficiently understandable to developers unfamiliar with Apple's internal terminology?
3. Should artwork geometry or content semantics determine component names?
4. Which variations deserve separate types versus configuration options?
5. Does `Card` remain appropriate for editorial, metric, and control presentations?

### Apple's internal architecture

6. Does Podcasts' `ShelfKit` use the same `Lockup` terminology?
7. Does `JetEngine.ComponentModel` serve the same role in Music and App Store?
8. What is the relationship between MusicUI component models and their SwiftUI rendering views?
9. How are collection layouts configured and registered?
10. Are any presentation components actually shared across multiple first-party applications?

### Platform adaptation

11. Do the same lockup families appear in tvOS and visionOS binaries?
12. Which component variations are shared across platforms?
13. Which require entirely different interaction models?
14. How much adaptive behavior should AppleSauce encode automatically?

### Visual verification

15. Can recovered types be correlated with specific Apple Music screenshots?
16. Can SwiftUI rendering signatures reveal meaningful layout decisions?
17. Which spacing and sizing rules remain consistent across multiple applications?
18. Can accessibility inspection provide additional evidence of semantic grouping?

---

## 7. Recommended next steps

### Priority 1 — Finalize AppleSauce's naming vocabulary

Before renaming existing components, compare two possible approaches:

**Geometry-oriented**

```swift
SquareLockup
PosterLockup
CircleLockup
HorizontalLockup
```

**Semantic**

```swift
AlbumLockup
ArtistLockup
PlaylistLockup
TrackLockup
```

The first emphasizes reusable visual presentations.

The second emphasizes domain-specific content.

A hybrid approach may be appropriate, but it should be deliberate.

**Deliverable:** An architecture decision record documenting the selected terminology and rationale.

### Priority 2 — Implement one reusable Lockup family

Start with `SquareLockup`.

Validate it against multiple real Apple Music contexts:

- Recently Played
- Made for You
- New Releases
- Related Content

Avoid creating screenshot-specific implementations.

**Deliverable:** One reusable component with documented variants and examples.

### Priority 3 — Implement a corresponding pattern

Build `MediaShelf` around the new lockup.

Verify:

- Content margins
- Item sizing
- Inter-item spacing
- Horizontal scrolling
- Partial next-item visibility
- Navigation
- Accessibility
- Dynamic Type
- Platform adaptation

**Deliverable:** A reusable pattern whose behavior has been validated in multiple screen contexts.

### Priority 4 — Investigate Podcasts' ShelfKit

The iOS 27 Podcasts application contains bundle references to:

```text
ShelfKit.framework
ShelfKitCollectionViews.framework
```

Their executable implementations were not located during this investigation.

Future research could establish whether these frameworks use the same terminology as MusicUI.

**Deliverable:** A separate `podcasts-shelfkit.md` research document, if meaningful findings become available.

### Priority 5 — Compare platform implementations

The installed Simulator runtimes provide opportunities to compare iOS, tvOS, watchOS, and visionOS.

Start with media-oriented UI patterns.

Do not assume feature parity across platforms.

**Deliverable:** A platform compatibility and adaptation matrix for each implemented pattern.

---

## 8. Research principles

Future binary investigations should follow these rules:

1. Record the exact OS, simulator build, and framework version.
2. Preserve raw symbol output separately from interpretations.
3. Distinguish observed names from inferred behavior.
4. Do not equate matching terminology with shared implementations.
5. Validate visual interpretations against actual application interfaces.
6. Prefer public SwiftUI APIs over private Apple framework dependencies.
7. Keep binary inspection read-only.
8. Never treat private Apple implementations as stable APIs.

---

## 9. Research conclusion

The investigation answered its primary question:

**Yes, Apple's compiled first-party applications expose useful internal UI terminology and architectural evidence.**

The most significant discovery is the recurring use of `Lockup` across MusicUI and AppStoreComponents.

The research also supports separating individual content presentations from the layouts and patterns that organize them.

For AppleSauce, the recommended direction is to develop a small, semantically meaningful family of reusable lockups, compose them into higher-level patterns, and validate those patterns across multiple Apple platforms.

**Status:** Research findings sufficient to inform initial architecture. Naming decisions remain open.

---
