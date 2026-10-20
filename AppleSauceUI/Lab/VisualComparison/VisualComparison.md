# Visual comparison workflow

The interactive `ReferenceComparison` UI is for live inspection while developing. The `Scripts/compare-ui` workflow uses either a real, running iPhone Simulator or an explicitly supplied capture and writes deterministic files for people and coding agents to inspect.

References may be taller than the current device viewport. Overlay and Difference keep the live app at its normal viewport size and translate only the full-page comparison image by the app’s current scroll offset. Reference uses a dedicated full-page scroll view restored to that same offset. This avoids nesting or resizing the app’s own scroll view.

Apply `visualComparisonScrollTracking()` to a screen’s primary vertical `ScrollView` to preserve its offset across comparison modes. The modifier restores the shared position when the UI reappears and reports user scrolling using normalized scroll geometry. The Apple Music Home example demonstrates this integration.

## Add a reference

Store each canonical screenshot as:

```text
AppleSauceUI/Lab/References/<Category>/<Product>/<Screen>/reference.png
```

For the target `media/apple-music/home`, the fixture directory is `AppleSauceUI/Lab/References/Media/AppleMusic/Home`. Target components must be lowercase kebab case; the script converts each component to PascalCase for fixture lookup. Both the script and `ReferenceSpec` resolve the collision-safe target name first (`media-apple-music-home-reference.png`), then `<screen>-reference.png`, then `reference.png`. Adding a target requires no script change.

Validated metadata JSON must sit beside the PNG. In synchronized Xcode folders, use the collision-safe target form (for example, `media-apple-podcasts-home-reference.png` and `.json`); `ReferenceSpec` also supports the legacy `reference.png` and `<screen>-reference.png` names.

```json
{
  "schemaVersion": 1,
  "target": "media/apple-music/home",
  "screen": "Apple Music — Home",
  "referenceType": "longScrolling",
  "image": { "widthPixels": 402, "heightPixels": 4091, "scale": null },
  "viewport": { "widthPixels": 402, "heightPixels": 874 },
  "appearance": "light",
  "dynamicType": "large",
  "capture": { "position": "full content, beginning at top" },
  "sections": [
    {
      "name": "top",
      "rectPixels": { "x": 0, "y": 0, "width": 402, "height": 874 },
      "position": "top"
    }
  ],
  "supportsFullContentComparison": true
}
```

`referenceType` is `singleViewport` or `longScrolling`. `image` always records the canonical PNG's measured pixel dimensions. `viewport` and `image.scale` are nullable when the source does not establish them; never infer a device model, OS, scale, or point size from bitmap dimensions. For a single-viewport reference, known viewport dimensions must equal image dimensions. Long references may define reproducible named sections using top-left pixel coordinates. `supportsFullContentComparison` must be explicitly true before the command accepts a full-content actual image.

Capture a new canonical reference with the intended simulator configured and the app showing only the screen under test. For example:

```sh
xcrun simctl io booted screenshot /tmp/reference.png
```

Inspect that image, then copy it into the appropriate reference directory. Canonical references are source fixtures and should be committed.

## Compare the running app

1. Run the app with every capture condition that the reference metadata establishes: viewport dimensions, orientation when recorded, appearance, and Dynamic Type size. Match a device, OS, or image scale only when metadata actually records it; do not infer unknown values from bitmap dimensions.
2. Launch with the argument `--visual-comparison-capture` to keep the existing VisualComparison panel, grid, guides, reference, and difference layers out of the framebuffer. Without that argument, ensure mode is **Actual** and all guides are off; the floating panel itself will remain visible and is not suitable for an authoritative capture.
3. Navigate to the intended screen and leave the app running.
4. From the repository root, run:

```sh
Scripts/compare-ui media/apple-music/home --section top
```

Use a supplied capture instead of the simulator framebuffer when needed:

```sh
Scripts/compare-ui media/apple-music/home --section top --actual /path/to/top.png
Scripts/compare-ui media/apple-music/home --full-content /path/to/full-content.png
```

Exactly one iPhone Simulator must be booted. Output appears under:

```text
Artifacts/VisualComparisons/media/apple-music/home/
├── reference-section-top.png
├── actual-section-top.png
├── overlay-50-section-top.png
├── diff-section-top.png
└── comparison-section-top.json
```

- `reference-section-top.png` is a derived, pixel-preserving crop; the manifest labels it and records its `x,y,width,height` coordinates from the canonical image's top-left.
- `actual-section-top.png` is the simulator framebuffer or explicitly supplied capture.
- `overlay-50-section-top.png` combines reference and actual at 50% each.
- `diff-section-top.png` is an emphasized absolute pixel difference: dark means close; bright means different.

Reference and actual dimensions must match exactly. The workflow never scales either image because scaling can conceal an incorrect simulator, orientation, display mode, image scale, or fixture. Unknown scale remains unknown rather than becoming an assumed device fact. A mismatch prints both dimensions and produces no new artifact set.

For `longScrolling` references, choose a named section or provide an explicitly supported full-content capture. Canonical files are never cropped or overwritten: all crops are derived artifacts. Each comparison manifest records the target and screen, canonical reference, comparison kind and crop coordinates, pixel dimensions, appearance, Dynamic Type, capture position and source, simulator when used, Git build revision and working-tree state, and UTC creation time.

Validate metadata and its canonical PNG directly with:

```sh
xcrun swift Scripts/ReferenceMetadataTool.swift validate reference.json reference.png
Scripts/Tests/reference-metadata-tests
```

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
