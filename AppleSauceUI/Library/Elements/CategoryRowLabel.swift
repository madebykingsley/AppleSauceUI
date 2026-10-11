import SwiftUI

struct CategoryRowLabel<Icon: View, Accessory: View>: View {
    @ViewBuilder let icon: Icon
    let title: LocalizedStringResource
    @ViewBuilder let accessory: Accessory

    var body: some View {
        HStack(spacing: 16) {
            icon.frame(width: 24)
            Text(title).font(.body)
            Spacer()
            accessory
                .font(.body.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .foregroundStyle(.primary)
        .frame(minHeight: 52)
        .contentShape(Rectangle())
    }
}

#if DEBUG
#Preview("CategoryRowLabel — Variants") {
    VStack(spacing: 0) { CategoryRowLabel(icon: { Image(systemName: "music.note") }, title: "Music"); CategoryRowLabel(icon: { Image(systemName: "mic") }, title: "Podcasts", accessory: { Text("12").font(.caption) }) }.padding().frame(width: 402)
}
#endif

extension CategoryRowLabel where Accessory == Image {
    init(@ViewBuilder icon: () -> Icon, title: LocalizedStringResource) {
        self.init(icon: icon, title: title) { Image(systemName: "chevron.forward") }
    }
}
