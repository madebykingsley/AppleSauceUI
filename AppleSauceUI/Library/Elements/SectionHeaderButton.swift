import SwiftUI

/// Adds explicit button semantics to the shared section-header presentation.
struct SectionHeaderButton<Leading: View>: View {
    let title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    var eyebrow: LocalizedStringKey?
    var showsChevron = true
    var contentMargins: CGFloat = 20
    let action: () -> Void
    @ViewBuilder let leading: Leading

    var body: some View {
        Button(action: action) {
            SectionHeader(title: title, subtitle: subtitle, eyebrow: eyebrow, leading: { leading }, accessory: {
                if showsChevron {
                    Image(systemName: "chevron.right")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            })
            .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, contentMargins)
        .accessibilityHint(showsChevron ? "Opens the section" : "")
    }
}

extension SectionHeaderButton where Leading == EmptyView {
    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        eyebrow: LocalizedStringKey? = nil,
        showsChevron: Bool = true,
        contentMargins: CGFloat = 20,
        action: @escaping () -> Void
    ) {
        self.init(title: title, subtitle: subtitle, eyebrow: eyebrow, showsChevron: showsChevron, contentMargins: contentMargins, action: action) { EmptyView() }
    }
}

#if DEBUG
#Preview("SectionHeaderButton — Variants") {
    VStack(alignment: .leading, spacing: 24) {
        SectionHeaderButton(title: "Browse Collection", action: {})
        SectionHeaderButton(title: "Subscriber Edition", eyebrow: "Featured", action: {}, leading: {
            Image(systemName: "play.tv.fill")
                .frame(width: 40, height: 40)
                .background(.black, in: Circle())
                .foregroundStyle(.white)
        })
    }
    .frame(width: 402)
}

#Preview("SectionHeaderButton — Accessibility") {
    ScrollView {
        SectionHeaderButton(title: "New Episodes and Recommendations", subtitle: "A longer subtitle remains beneath the heading", action: {})
            .dynamicTypeSize(.accessibility3)
    }
    .frame(width: 402)
}
#endif
