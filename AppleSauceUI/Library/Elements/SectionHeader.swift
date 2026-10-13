import SwiftUI

enum SectionHeaderProminence {
    case standard
    case prominent
}

/// Shared section-heading presentation. Compose it inside a native control when the heading is actionable.
struct SectionHeader<Leading: View, Accessory: View>: View {
    @Environment(\.styleProfile) private var styleProfile

    let title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    var eyebrow: LocalizedStringKey?
    var prominence = SectionHeaderProminence.standard
    var spacing: CGFloat = 10
    @ViewBuilder let leading: Leading
    @ViewBuilder let accessory: Accessory

    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            leading
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                if let eyebrow {
                    Text(eyebrow)
                        .font(styleProfile.typography.body)
                        .foregroundStyle(styleProfile.colors.secondaryText)
                }
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(title)
                        .font(prominence == .prominent ? styleProfile.typography.prominentSectionTitle : styleProfile.typography.sectionTitle)
                        .foregroundStyle(styleProfile.colors.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                    accessory
                }
                if let subtitle {
                    Text(subtitle)
                        .font(styleProfile.typography.body)
                        .foregroundStyle(styleProfile.colors.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 0)
        }
    }
}

extension SectionHeader where Leading == EmptyView {
    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        eyebrow: LocalizedStringKey? = nil,
        prominence: SectionHeaderProminence = .standard,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.init(title: title, subtitle: subtitle, eyebrow: eyebrow, prominence: prominence, leading: { EmptyView() }, accessory: accessory)
    }
}

extension SectionHeader where Accessory == EmptyView {
    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        eyebrow: LocalizedStringKey? = nil,
        prominence: SectionHeaderProminence = .standard,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(title: title, subtitle: subtitle, eyebrow: eyebrow, prominence: prominence, leading: leading, accessory: { EmptyView() })
    }
}

extension SectionHeader where Leading == EmptyView, Accessory == EmptyView {
    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        eyebrow: LocalizedStringKey? = nil,
        prominence: SectionHeaderProminence = .standard
    ) {
        self.init(title: title, subtitle: subtitle, eyebrow: eyebrow, prominence: prominence, leading: { EmptyView() }, accessory: { EmptyView() })
    }
}

#if DEBUG
#Preview("SectionHeader — Variants") {
    VStack(alignment: .leading, spacing: 24) {
        SectionHeader(title: "Plain")
        SectionHeader(title: "With Subtitle", subtitle: "Supporting context for this collection")
        SectionHeader(title: "With Artwork", eyebrow: "Recommended", leading: {
            Image(systemName: "music.note")
                .frame(width: 40, height: 40)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
        })
        SectionHeader(title: "With Accessory", accessory: {
            Image(systemName: "chevron.right").foregroundStyle(.secondary)
        })
        Button(action: {}) {
            SectionHeader(title: "Actionable", accessory: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            })
        }
        .buttonStyle(.plain)
    }
    .padding()
    .frame(width: 402)
}

#Preview("SectionHeader — Long Content") {
    SectionHeader(title: "A Long Section Title That Wraps", subtitle: "Long supporting information remains below the title and its accessory", accessory: {
        Image(systemName: "chevron.right").foregroundStyle(.secondary)
    })
    .padding()
    .frame(width: 402)
}
#endif
