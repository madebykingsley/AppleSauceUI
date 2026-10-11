import SwiftUI

struct StyleProfileGridSection: View {
    let profile: StyleProfile
    let density: InterfaceDensity
    let items: [StyleProfileMediaItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(profile.name)
                .font(.caption.weight(.semibold))
                .foregroundStyle(profile.colors.secondaryText)
                .textCase(.uppercase)
                .padding(.horizontal, 20)

            MediaGrid(title: "Essential Listening", items: items) { item in
                SquareLockup(title: item.title, subtitle: item.creator) {
                    ArtworkPlaceholder(
                        symbol: item.symbol,
                        background: AnyShapeStyle(
                            LinearGradient(
                                colors: item.colors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        ),
                        symbolPadding: 42
                    )
                }
            }
        }
        .padding(.vertical, 18)
        .background(profile.colors.surface)
        .styleProfile(profile, honorsPreferredColorScheme: false)
        .interfaceDensity(density)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(profile.name)
    }
}

#if DEBUG
#Preview("StyleProfileGridSection — Entertainment Standard") {
    ScrollView {
        StyleProfileGridSection(
            profile: .entertainment,
            density: .standard,
            items: StyleProfileMediaItem.samples
        )
    }
}

#Preview("StyleProfileGridSection — Editorial Spacious") {
    ScrollView {
        StyleProfileGridSection(
            profile: .editorial,
            density: .spacious,
            items: StyleProfileMediaItem.samples
        )
    }
}

#Preview("StyleProfileGridSection — Neutral Compact") {
    ScrollView {
        StyleProfileGridSection(
            profile: .neutral,
            density: .compact,
            items: StyleProfileMediaItem.samples
        )
    }
}
#endif
