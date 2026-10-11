import SwiftUI

struct PlaybackButton: View {
    let label: String
    let accessibilityLabel: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(label, systemImage: "play.fill")
        }
        .font(.caption.weight(.semibold))
        .buttonStyle(.bordered)
        .accessibilityLabel(accessibilityLabel)
    }
}

#if DEBUG
#Preview("PlaybackButton — Variants") { HStack { PlaybackButton(label: "Play", accessibilityLabel: "Play episode", action: {}); PlaybackButton(label: "24 min", accessibilityLabel: "Play episode, 24 minutes", action: {}) }.padding().tint(.purple) }
#endif
