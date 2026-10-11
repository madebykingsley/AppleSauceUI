import SwiftUI

struct StyleProfilesExample: View {
    @State private var comparison = StyleProfileComparison.shelf
    @State private var cardLayout = MediaCardLayout.standard
    @State private var density = InterfaceDensity.standard

    let onExit: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    Picker("Comparison", selection: $comparison) {
                        ForEach(StyleProfileComparison.allCases) { comparison in
                            Text(comparison.name).tag(comparison)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    if comparison == .card {
                        Picker("Card layout", selection: $cardLayout) {
                            ForEach(MediaCardLayout.allCases) { layout in
                                Text(layout.name).tag(layout)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                    }

                    Picker("Density", selection: $density) {
                        ForEach(InterfaceDensity.allCases) { density in
                            Text(density.name).tag(density)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    ForEach(StyleProfile.allCases) { profile in
                        switch comparison {
                        case .shelf:
                            StyleProfileShelfSection(
                                profile: profile,
                                density: density,
                                items: StyleProfileMediaItem.samples
                            )
                        case .grid:
                            StyleProfileGridSection(
                                profile: profile,
                                density: density,
                                items: StyleProfileMediaItem.samples
                            )
                        case .card:
                            StyleProfileMediaCardSection(
                                profile: profile,
                                density: density,
                                layout: cardLayout
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(comparison.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close", systemImage: "xmark", action: onExit)
                }
            }
        }
    }
}

enum StyleProfileComparison: String, CaseIterable, Identifiable {
    case shelf
    case grid
    case card

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .shelf: "MediaShelf"
        case .grid: "MediaGrid"
        case .card: "MediaCard"
        }
    }
}

#if DEBUG
#Preview("StyleProfilesExample — Comparison") {
    StyleProfilesExample(onExit: {})
}
#endif
