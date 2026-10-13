import SwiftUI

struct PlaybackButton: View {
    let label: String
    let accessibilityLabel: String
    var progress: Double?
    let action: () -> Void

    init(
        label: String,
        accessibilityLabel: String,
        progress: Double? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.accessibilityLabel = accessibilityLabel
        self.progress = progress.map { min(max($0, 0), 1) }
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Label(label, systemImage: "play.fill")

                if let progress {
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                        .accessibilityHidden(true)
                }
            }
        }
        .font(.caption.weight(.semibold))
        .buttonStyle(.bordered)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityValue(progress.map { "\(Int($0 * 100)) percent" } ?? "")
    }
}

#if DEBUG
#Preview("PlaybackButton — Variants") { HStack { PlaybackButton(label: "Play", accessibilityLabel: "Play episode", action: {}); PlaybackButton(label: "24 min", accessibilityLabel: "Play episode, 24 minutes", action: {}) }.padding().tint(.purple) }
#endif
