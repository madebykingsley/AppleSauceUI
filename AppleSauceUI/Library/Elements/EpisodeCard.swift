import SwiftUI

struct EpisodeCard<Background: ShapeStyle, Artwork: View>: View {
    let show: String; let title: String; let date: String; let description: String; let duration: String
    let background: Background; let playAction: () -> Void; let overflowAction: () -> Void
    @ViewBuilder let artwork: Artwork

    var body: some View {
        MediaCard(background: background) { artwork } details: {
            VStack(alignment: .leading, spacing: 5) {
                Text(date).font(.caption2).foregroundStyle(.white.opacity(0.72))
                Text(show).font(.caption.weight(.semibold)).lineLimit(1)
                Text(title).font(.headline).lineLimit(2)
                Text(description).font(.caption).foregroundStyle(.white.opacity(0.78)).lineLimit(3)
                HStack { PlaybackButton(label: "Play \(duration)", accessibilityLabel: "Play \(title), \(duration)", action: playAction).tint(.white); Spacer(); Button("More", systemImage: "ellipsis", action: overflowAction).labelStyle(.iconOnly).accessibilityLabel("More options for \(title)") }.padding(.top, 3)
            }.padding(12)
        }
    }
}

#if DEBUG
#Preview("EpisodeCard — Variants") {
    EpisodeCard(show: "Daily Stories", title: "A Walk Through the City", date: "Today", description: "A reported story about how public spaces shape everyday life.", duration: "24 min", background: .indigo.gradient, playAction: {}, overflowAction: {}) { Rectangle().fill(.white.opacity(0.12)).aspectRatio(1.6, contentMode: .fit).overlay { Image(systemName: "mic.fill") } }.padding().frame(width: 402)
}
#endif
