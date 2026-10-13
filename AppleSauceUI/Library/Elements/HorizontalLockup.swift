import SwiftUI

/// A leading-artwork presentation that adapts its accessory at accessibility sizes.
struct HorizontalLockup<Artwork: View, Accessory: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.styleProfile) private var styleProfile

    let title: String
    var subtitle: String?
    var metadata: String?
    var spacing: CGFloat = 12
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let accessory: Accessory

    var body: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: spacing) {
                HStack(alignment: .top, spacing: spacing) {
                    artwork.accessibilityHidden(true)
                    labels.frame(maxWidth: .infinity, alignment: .leading)
                }
                accessory.frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(spacing: spacing) {
                artwork.accessibilityHidden(true)
                labels.frame(maxWidth: .infinity, alignment: .leading)
                accessory
            }
        }
    }

    private var labels: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(styleProfile.typography.body)
                .foregroundStyle(styleProfile.colors.primaryText)
                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
            if let subtitle {
                Text(subtitle)
                    .font(styleProfile.typography.itemSubtitle)
                    .foregroundStyle(styleProfile.colors.secondaryText)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
            }
            if let metadata {
                Text(metadata)
                    .font(styleProfile.typography.metadata)
                    .foregroundStyle(styleProfile.colors.secondaryText)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

extension HorizontalLockup where Accessory == EmptyView {
    init(title: String, subtitle: String? = nil, metadata: String? = nil, spacing: CGFloat = 12, @ViewBuilder artwork: () -> Artwork) {
        self.init(title: title, subtitle: subtitle, metadata: metadata, spacing: spacing, artwork: artwork, accessory: { EmptyView() })
    }
}

#if DEBUG
#Preview("HorizontalLockup — Variants") {
    HorizontalLockup(title: "Track Title", subtitle: "Artist") {
        ArtworkThumbnail(symbol: "music.note", background: AnyShapeStyle(.blue.gradient), size: 48)
    } accessory: {
        Button("More actions", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
    }
    .padding()
}


#Preview("HorizontalLockup — Accessibility") {
    HorizontalLockup(title: "A Track Title That Wraps at Accessibility Sizes", subtitle: "Artist") {
        ArtworkThumbnail(symbol: "music.note", background: AnyShapeStyle(.blue.gradient), size: 48)
    } accessory: {
        Button("More actions", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly)
    }
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
