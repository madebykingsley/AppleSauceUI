import SwiftUI

struct StyleProfileElementsSection: View {
    let profile: StyleProfile
    let density: InterfaceDensity

    var body: some View {
        VStack(alignment: .leading, spacing: density.metrics.sectionSpacing) {
            Text(profile.name)
                .font(.caption.weight(.semibold))
                .foregroundStyle(profile.colors.secondaryText)
                .textCase(.uppercase)

            PosterLockup(
                title: "The Shape of Quiet",
                eyebrow: "Field Recording",
                subtitle: "A journey through places transformed by sound",
                height: 300
            ) {
                ArtworkPlaceholder(
                    symbol: "waveform.path.ecg",
                    background: artworkBackground,
                    symbolPadding: 72
                )
            }
            .frame(maxWidth: 248)

            EditorialHero(eyebrow: "Editors’ Choice", title: "Stories shaped by sound and place") {
                ArtworkPlaceholder(
                    symbol: "headphones",
                    background: artworkBackground,
                    symbolPadding: 56
                )
            }

            EpisodeRow(
                title: "Listening for a Changing City",
                show: "Field Notes",
                date: "Today",
                duration: "32 min",
                badge: "NEW",
                presentation: .featured,
                playAction: {},
                overflowAction: {},
                skipForwardAction: {}
            ) {
                ArtworkPlaceholder(
                    symbol: "building.2.fill",
                    background: artworkBackground,
                    symbolPadding: 12
                )
            }
        }
        .padding(density.metrics.contentMargin)
        .background(profile.colors.surface)
        .styleProfile(profile, honorsPreferredColorScheme: false)
        .interfaceDensity(density)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(profile.name)
    }

    private var artworkBackground: AnyShapeStyle {
        AnyShapeStyle(
            LinearGradient(
                colors: [.indigo, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

#if DEBUG
#Preview("StyleProfileElementsSection — Editorial Spacious") {
    ScrollView {
        StyleProfileElementsSection(profile: .editorial, density: .spacious)
    }
}

#Preview("StyleProfileElementsSection — Entertainment Standard") {
    ScrollView {
        StyleProfileElementsSection(profile: .entertainment, density: .standard)
    }
}

#Preview("StyleProfileElementsSection — Neutral Compact") {
    ScrollView {
        StyleProfileElementsSection(profile: .neutral, density: .compact)
    }
}
#endif
