import SwiftUI

enum NavigationListItemStyle: Equatable, Sendable {
    case capsule
    case plain
}

/// A text navigation-row presentation intended for use inside a native control.
struct NavigationListItem: View {
    @Environment(\.interfaceDensity) private var density

    let title: LocalizedStringResource
    let style: NavigationListItemStyle

    var body: some View {
        switch style {
        case .capsule:
            HStack {
                titleText
                Spacer(minLength: density.metrics.itemSpacing)
                Image(systemName: "chevron.right")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.tint)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, density.metrics.contentPadding)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background(
                Color(uiColor: .quaternarySystemFill),
                in: RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
        case .plain:
            VStack(spacing: 0) {
                titleText
                    .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
                Divider()
            }
        }
    }

    private var titleText: some View {
        Text(title)
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(.tint)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#if DEBUG
#Preview("NavigationListItem — Variants") {
    VStack(spacing: 12) {
        NavigationListItem(title: "Browse by Genre", style: .capsule)
        NavigationListItem(title: "Explore Destinations", style: .plain)
    }
    .padding()
    .frame(width: 402)
    .tint(.pink)
}

#Preview("NavigationListItem — Accessibility") {
    VStack(spacing: 12) {
        NavigationListItem(
            title: "A Longer Navigation Destination That Can Wrap",
            style: .capsule
        )
        NavigationListItem(
            title: "Another Longer Destination That Remains Readable",
            style: .plain
        )
    }
    .padding()
    .frame(width: 402)
    .tint(.purple)
    .dynamicTypeSize(.accessibility2)
}
#endif
