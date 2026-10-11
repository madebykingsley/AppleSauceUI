import SwiftUI

struct MetadataBadge: View {
    let label: String
    var body: some View { Text(label).font(.caption2.weight(.semibold)).foregroundStyle(.secondary).padding(.horizontal, 3).background(.secondary.opacity(0.16), in: RoundedRectangle(cornerRadius: 2)) }
}

#if DEBUG
#Preview("MetadataBadge — Variants") { HStack { MetadataBadge(label: "E"); MetadataBadge(label: "NEW") }.padding() }
#endif
