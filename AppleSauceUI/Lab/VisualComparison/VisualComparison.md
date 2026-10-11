# Visual comparison workflow

The interactive `ReferenceComparison` UI is for live inspection while developing. The `Scripts/compare-ui` workflow separately captures the real, running iPhone Simulator and writes deterministic files for people and coding agents to inspect.

References may be taller than the current device viewport. Overlay and Difference keep the live app at its normal viewport size and translate only the full-page comparison image by the app’s current scroll offset. Reference uses a dedicated full-page scroll view restored to that same offset. This avoids nesting or resizing the app’s own scroll view.

Apply `visualComparisonScrollTracking()` to a screen’s primary vertical `ScrollView` to preserve its offset across comparison modes. The modifier restores the shared position when the UI reappears and reports user scrolling using normalized scroll geometry. The Apple Music Home example demonstrates this integration.

## Add a reference

Store each canonical screenshot as:

```text
AppleSauceUI/Lab/References/<Category>/<Product>/<Screen>/reference.png
```

For the target `media/apple-music/home`, the fixture directory is `AppleSauceUI/Lab/References/Media/AppleMusic/Home`. Target components must be lowercase kebab case; the script converts each component to PascalCase for fixture lookup. Both the script and `ReferenceSpec` resolve the collision-safe target name first (`media-apple-music-home-reference.png`), then `<screen>-reference.png`, then `reference.png`. Adding a target requires no script change.

An optional metadata JSON may sit beside the PNG and document capture conditions. In synchronized Xcode folders, use the collision-safe target form (for example, `media-apple-podcasts-home-reference.png` and `.json`); `ReferenceSpec` also supports the legacy `reference.png` and `<screen>-reference.png` names.

```json
{
  "name": "Apple Music — Home",
  "platform": "iOS",
  "os": "27.0",
  "device": "iPhone 17 Pro",
  "orientation": "portrait",
  "appearance": "light",
  "dynamicType": "large"
}
```

Capture a new canonical reference with the intended simulator configured and the app showing only the screen under test. For example:

```sh
xcrun simctl io booted screenshot /tmp/reference.png
```

Inspect that image, then copy it into the appropriate reference directory. Canonical references are source fixtures and should be committed.

## Compare the running app

1. Run the app on the iPhone Simulator matching the reference device, OS, orientation, appearance, and Dynamic Type size.
2. Launch with the argument `--visual-comparison-capture` to keep the existing VisualComparison panel, grid, guides, reference, and difference layers out of the framebuffer. Without that argument, ensure mode is **Actual** and all guides are off; the floating panel itself will remain visible and is not suitable for an authoritative capture.
3. Navigate to the intended screen and leave the app running.
4. From the repository root, run:

```sh
Scripts/compare-ui media/apple-music/home
```

Exactly one iPhone Simulator must be booted. Output appears under:

```text
Artifacts/VisualComparisons/media/apple-music/home/
├── reference.png
├── actual.png
├── overlay-50.png
└── diff.png
```

- `reference.png` is a pixel-preserving copy of the canonical fixture.
- `actual.png` is the real simulator framebuffer.
- `overlay-50.png` combines reference and actual at 50% each.
- `diff.png` is an emphasized absolute pixel difference: dark means close; bright means different.

Reference and actual dimensions must match exactly for command-line framebuffer comparisons. The workflow never scales either image because scaling can conceal an incorrect simulator, orientation, display mode, or fixture. On a mismatch, it prints both dimensions and produces no new artifact set. Use the interactive comparison UI to inspect a stitched or full-page reference whose height exceeds the viewport.

## Intended iteration

```text
edit SwiftUI
    ↓
build and run on the matching simulator
    ↓
run Scripts/compare-ui
    ↓
inspect actual, overlay, and diff
    ↓
refine the implementation
```

The command captures and compares only. It does not drive Xcode Intelligence, edit code, build the app, provision simulators, or navigate the UI.
