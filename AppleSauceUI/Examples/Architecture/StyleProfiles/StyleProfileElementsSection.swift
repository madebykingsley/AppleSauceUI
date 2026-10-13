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

            HorizontalLockup(artworkSize: 90, spacing: 11, alignment: .top) {
                ArtworkPlaceholder(
                    symbol: "building.2.fill",
                    background: artworkBackground,
                    symbolPadding: 12
                )
                .accessibilityHidden(true)
            } content: {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Field Notes")
                            .font(.caption2)
                            .foregroundStyle(profile.colors.secondaryText)
                        Text("Listening for a Changing City")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(profile.colors.primaryText)
                        HStack(spacing: 4) {
                            Text("Today")
                            Text("·")
                            Text("32 min")
                            MetadataBadge(label: "NEW")
                        }
                        .font(.footnote)
                        .foregroundStyle(profile.colors.secondaryText)
                    }
                    .accessibilityElement(children: .combine)
                    PlaybackButton(label: "32 min", accessibilityLabel: "Play Listening for a Changing City, 32 minutes", action: {})
                }
            } accessory: {
                Button("More options for Listening for a Changing City", systemImage: "ellipsis", action: {})
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundStyle(profile.colors.secondaryText)
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
