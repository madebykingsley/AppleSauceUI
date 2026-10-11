import SwiftUI

struct StyleProfilesExample: View {
    @State private var density = InterfaceDensity.standard

    let onExit: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    Picker("Density", selection: $density) {
                        ForEach(InterfaceDensity.allCases) { density in
                            Text(density.name).tag(density)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    ForEach(StyleProfile.allCases) { profile in
                        StyleProfileShelfSection(
                            profile: profile,
                            density: density,
                            items: StyleProfileMediaItem.samples
                        )
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("MediaShelf")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close", systemImage: "xmark", action: onExit)
                }
            }
        }
    }
}

#if DEBUG
#Preview("StyleProfilesExample — Comparison") {
    StyleProfilesExample(onExit: {})
}
#endif
