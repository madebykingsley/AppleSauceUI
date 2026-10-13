import SwiftUI

/// A geometry-only presentation for leading artwork, flexible content, and an optional accessory.
struct HorizontalLockup<Artwork: View, Content: View, Accessory: View>: View {
    let artworkSize: CGSize
    let spacing: CGFloat
    let alignment: VerticalAlignment
    let accessoryAlignment: VerticalAlignment
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let content: Content
    @ViewBuilder let accessory: Accessory

    init(
        artworkSize: CGSize,
        spacing: CGFloat = 12,
        alignment: VerticalAlignment = .center,
        accessoryAlignment: VerticalAlignment = .center,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder content: () -> Content,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.artworkSize = artworkSize
        self.spacing = spacing
        self.alignment = alignment
        self.accessoryAlignment = accessoryAlignment
        self.artwork = artwork()
        self.content = content()
        self.accessory = accessory()
    }

    init(
        artworkSize: CGFloat,
        spacing: CGFloat = 12,
        alignment: VerticalAlignment = .center,
        accessoryAlignment: VerticalAlignment = .center,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder content: () -> Content,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.init(
            artworkSize: CGSize(width: artworkSize, height: artworkSize),
            spacing: spacing,
            alignment: alignment,
            accessoryAlignment: accessoryAlignment,
            artwork: artwork,
            content: content,
            accessory: accessory
        )
    }

    var body: some View {
        HStack(alignment: accessoryAlignment) {
            HStack(alignment: alignment, spacing: spacing) {
                artwork
                    .frame(width: artworkSize.width, height: artworkSize.height)

                content
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)
            }

            accessory
        }
    }
}

extension HorizontalLockup where Accessory == EmptyView {
    init(
        artworkSize: CGSize,
        spacing: CGFloat = 12,
        alignment: VerticalAlignment = .center,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            artworkSize: artworkSize,
            spacing: spacing,
            alignment: alignment,
            artwork: artwork,
            content: content,
            accessory: { EmptyView() }
        )
    }

    init(
        artworkSize: CGFloat,
        spacing: CGFloat = 12,
        alignment: VerticalAlignment = .center,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            artworkSize: CGSize(width: artworkSize, height: artworkSize),
            spacing: spacing,
            alignment: alignment,
            artwork: artwork,
            content: content
        )
    }
}

#if DEBUG
#Preview("HorizontalLockup — Variants") {
    ScrollView {
        VStack(spacing: 24) {
            HorizontalLockup(artworkSize: 48, spacing: 11) {
                ArtworkPlaceholder(symbol: "music.note", background: AnyShapeStyle(.blue.gradient), symbolPadding: 12)
            } content: {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Track Title").font(.callout).lineLimit(1)
                    Text("Artist").font(.footnote).foregroundStyle(.secondary).lineLimit(1)
                }
            } accessory: {
                Button("More actions for Track Title", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
            }

            HorizontalLockup(artworkSize: 63, spacing: 20) {
                ArtworkPlaceholder(symbol: "mic.fill", background: AnyShapeStyle(.indigo.gradient), symbolPadding: 16)
            } content: {
                VStack(alignment: .leading, spacing: 2) {
                    Text("A Compact Podcast Episode with a Multiline Title").font(.body.weight(.semibold))
                    Text("Today · 24 min").font(.footnote).foregroundStyle(.secondary)
                }
            } accessory: {
                Button("More options for episode", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
            }

            HorizontalLockup(artworkSize: 90, spacing: 11, alignment: .top) {
                ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), symbolPadding: 20)
            } content: {
                VStack(alignment: .leading, spacing: 8) {
                    Text("YESTERDAY").font(.caption2).foregroundStyle(.secondary)
                    Text("A Featured Episode Title That Wraps Across Multiple Lines").font(.body.weight(.semibold))
                    PlaybackButton(label: "38 min", accessibilityLabel: "Play featured episode, 38 minutes", action: {})
                }
            } accessory: {
                Button("More options for featured episode", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
            }

            HorizontalLockup(artworkSize: 102, spacing: 12) {
                ArtworkPlaceholder(symbol: "music.note.list", background: AnyShapeStyle(.orange.gradient), symbolPadding: 24)
            } content: {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Large Music Lockup").font(.subheadline)
                    Text("Album · Artist").font(.footnote).foregroundStyle(.secondary)
                    Text("FROM A FRIEND")
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(.quaternary, in: Capsule())
                }
            }

            HorizontalLockup(artworkSize: 102, spacing: 12, alignment: .top) {
                ArtworkPlaceholder(symbol: "dot.radiowaves.left.and.right", background: AnyShapeStyle(.pink.gradient), symbolPadding: 24)
            } content: {
                VStack(alignment: .leading, spacing: 3) {
                    Text("FEATURED STATION").font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                    Text("The Editorial Mix").font(.callout)
                    Text("A longer description that can wrap naturally across multiple lines.").font(.footnote).foregroundStyle(.secondary)
                }
            } accessory: {
                Button("More actions for The Editorial Mix", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
            }
        }
        .padding()
    }
}

#Preview("HorizontalLockup — Accessibility") {
    ScrollView {
        HorizontalLockup(artworkSize: 90, spacing: 11, alignment: .top) {
            ArtworkPlaceholder(symbol: "waveform", background: AnyShapeStyle(.purple.gradient), symbolPadding: 20)
        } content: {
            VStack(alignment: .leading, spacing: 8) {
                Text("YESTERDAY").font(.caption2).foregroundStyle(.secondary)
                Text("A Long Episode Title at an Accessibility Text Size").font(.body.weight(.semibold))
                PlaybackButton(label: "38 min", accessibilityLabel: "Play episode, 38 minutes", action: {})
            }
        } accessory: {
            Button("More options for episode", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
        }
        .padding()
    }
    .dynamicTypeSize(.accessibility3)
}
#endif
