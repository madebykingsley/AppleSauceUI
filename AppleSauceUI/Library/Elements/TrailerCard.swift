import SwiftUI

struct TrailerCard<Background: ShapeStyle, Artwork: View>: View {
    let title: String; let description: String; let duration: String; let background: Background
    let playAction: () -> Void; let followAction: () -> Void
    @ViewBuilder let artwork: Artwork

    var body: some View {
        MediaCard(background: background) { artwork } details: {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline).lineLimit(2)
                Text(description).font(.caption).foregroundStyle(.white.opacity(0.78)).lineLimit(3)
                HStack { PlaybackButton(label: duration, accessibilityLabel: "Play trailer for \(title)", action: playAction).tint(.white); Spacer(); Button("Follow", systemImage: "plus", action: followAction).labelStyle(.iconOnly).accessibilityLabel("Follow \(title)") }.padding(.top, 3)
            }.padding(12)
        }
    }
}

#if DEBUG
#Preview("TrailerCard — Variants") {
    TrailerCard(title: "A New Series", description: "Hear the first moments of a thoughtful new conversation.", duration: "2 min", background: .teal.gradient, playAction: {}, followAction: {}) { Rectangle().fill(.white.opacity(0.12)).aspectRatio(1.6, contentMode: .fit).overlay { Image(systemName: "play.rectangle.fill") } }.padding().frame(width: 402)
}
#endif
