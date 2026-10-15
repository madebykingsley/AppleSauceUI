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
            HStack(spacing: 8) {
                Image(systemName: "play.fill")

                if let progress {
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                        .frame(width: 25)
                        .accessibilityHidden(true)
                }

                Text(label)
            }
        }
        .font(.caption.weight(.semibold))
        .buttonStyle(.bordered)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityValue(progress.map { "\(Int($0 * 100)) percent" } ?? "")
    }
}

#if DEBUG
#Preview("PlaybackButton — Variants") {
    HStack {
        PlaybackButton(
            label: "24m",
            accessibilityLabel: "Play episode, 24 minutes remaining",
            action: {}
        )
        PlaybackButton(
            label: "4m",
            accessibilityLabel: "Play episode, 4 minutes remaining",
            progress: 0.5,
            action: {}
        )
    }
    .padding()
    .tint(.purple)
}
#endif
