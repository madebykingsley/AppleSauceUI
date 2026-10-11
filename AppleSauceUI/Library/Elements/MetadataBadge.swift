import SwiftUI

struct MetadataBadge: View {
    @Environment(\.styleProfile) private var styleProfile

    let label: String
    var accessibilityLabel: String?
    var context = MetadataBadgeContext.standard

    var body: some View {
        Text(label)
            .font(styleProfile.typography.eyebrow)
            .foregroundStyle(foreground)
            .padding(.horizontal, 4)
            .padding(.vertical, 1)
            .background(foreground.opacity(0.14), in: RoundedRectangle(cornerRadius: 2))
            .accessibilityLabel(accessibilityLabel ?? label)
    }

    private var foreground: Color {
        context == .onMedia ? styleProfile.colors.onMedia : styleProfile.colors.secondaryText
    }
}

enum MetadataBadgeContext {
    case standard
    case onMedia
}

#if DEBUG
#Preview("MetadataBadge — Variants") { HStack { MetadataBadge(label: "E"); MetadataBadge(label: "NEW") }.padding() }
#endif
