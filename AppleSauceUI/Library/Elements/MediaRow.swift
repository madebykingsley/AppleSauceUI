import SwiftUI

struct MediaRow<Leading: View, Content: View, Accessory: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var spacing: CGFloat = 12
    @ViewBuilder let leading: Leading
    @ViewBuilder let content: Content
    @ViewBuilder let accessory: Accessory

    var body: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: spacing) {
                HStack(alignment: .top, spacing: spacing) {
                    leading
                    content.frame(maxWidth: .infinity, alignment: .leading)
                }
                accessory.frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(spacing: spacing) {
                leading
                content.frame(maxWidth: .infinity, alignment: .leading)
                accessory
            }
        }
    }
}

#if DEBUG
#Preview("MediaRow — Variants") {
    VStack(spacing: 16) {
        MediaRow { Image(systemName: "music.note").frame(width: 48, height: 48).background(.quaternary) } content: { VStack(alignment: .leading) { Text("Track Title"); Text("Artist").font(.caption).foregroundStyle(.secondary) } }
        MediaRow { Image(systemName: "waveform").frame(width: 48, height: 48).background(.quaternary) } content: { VStack(alignment: .leading) { Text("Longer Primary Content That Can Wrap"); Text("Additional metadata").font(.caption).foregroundStyle(.secondary); ProgressView(value: 0.6) } } accessory: { Button("More", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly) }
    }.padding().frame(width: 480)
}

#Preview("MediaRow — Accessibility") {
    MediaRow { Image(systemName: "waveform").frame(width: 48, height: 48).background(.quaternary) } content: { Text("Content adapts at accessibility sizes") } accessory: { Button("More", systemImage: "ellipsis", action: {}).labelStyle(.iconOnly) }.padding().dynamicTypeSize(.accessibility3).frame(width: 402)
}
#endif

extension MediaRow where Accessory == EmptyView {
    init(spacing: CGFloat = 12, @ViewBuilder leading: () -> Leading, @ViewBuilder content: () -> Content) {
        self.init(spacing: spacing, leading: leading, content: content) { EmptyView() }
    }
}
