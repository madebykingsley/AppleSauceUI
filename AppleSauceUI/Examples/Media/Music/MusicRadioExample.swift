import SwiftUI

struct MusicRadioExample: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Radio", systemImage: "dot.radiowaves.left.and.right")
                .navigationTitle("Radio")
        }
    }
}

#if DEBUG
#Preview {
    MusicRadioExample()
}
#endif
