import SwiftUI

struct StyleProfilesExample: View {
    @State private var pattern = StyleProfilePattern.shelf
    @State private var density = InterfaceDensity.standard

    let onExit: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    Picker("Pattern", selection: $pattern) {
                        ForEach(StyleProfilePattern.allCases) { pattern in
                            Text(pattern.name).tag(pattern)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    Picker("Density", selection: $density) {
                        ForEach(InterfaceDensity.allCases) { density in
                            Text(density.name).tag(density)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    ForEach(StyleProfile.allCases) { profile in
                        switch pattern {
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
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(pattern.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close", systemImage: "xmark", action: onExit)
                }
            }
        }
    }
}

enum StyleProfilePattern: String, CaseIterable, Identifiable {
    case shelf
    case grid

    var id: Self { self }

    var name: LocalizedStringResource {
        switch self {
        case .shelf: "MediaShelf"
        case .grid: "MediaGrid"
        }
    }
}

#if DEBUG
#Preview("StyleProfilesExample — Comparison") {
    StyleProfilesExample(onExit: {})
}
#endif
