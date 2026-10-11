import SwiftUI

struct StyleProfileMediaCardSection: View {
    let profile: StyleProfile
    let density: InterfaceDensity
    let layout: MediaCardLayout

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(profile.name)
                .font(.caption.weight(.semibold))
                .foregroundStyle(profile.colors.secondaryText)
                .textCase(.uppercase)

            MediaCard(
                layout: layout,
                eyebrow: "Field Recording",
                title: "The Shape of Quiet",
                subtitle: "An immersive journey through places transformed by sound and silence.",
                metadata: "Documentary · 42 min",
                badge: "NEW"
            ) {
                ArtworkPlaceholder(
                    symbol: "waveform.path.ecg",
                    background: AnyShapeStyle(
                        LinearGradient(
                            colors: [.indigo, .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ),
                    symbolPadding: 64
                )
                .aspectRatio(1.6, contentMode: .fit)
            }
        }
        .padding(density.metrics.contentMargin)
        .background(profile.colors.surface)
        .styleProfile(profile, honorsPreferredColorScheme: false)
        .interfaceDensity(density)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(profile.name)
    }
}

#if DEBUG
#Preview("StyleProfileMediaCardSection — Editorial Spacious") {
    ScrollView {
        StyleProfileMediaCardSection(profile: .editorial, density: .spacious, layout: .standard)
    }
}

#Preview("StyleProfileMediaCardSection — Entertainment Standard") {
    ScrollView {
        StyleProfileMediaCardSection(profile: .entertainment, density: .standard, layout: .standard)
    }
}

#Preview("StyleProfileMediaCardSection — Neutral Compact") {
    ScrollView {
        StyleProfileMediaCardSection(profile: .neutral, density: .compact, layout: .standard)
    }
}

#Preview("StyleProfileMediaCardSection — Overlay") {
    ScrollView {
        StyleProfileMediaCardSection(profile: .entertainment, density: .standard, layout: .overlay)
    }
}
#endif
