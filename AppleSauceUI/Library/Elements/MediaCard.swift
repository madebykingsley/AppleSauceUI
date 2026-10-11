import SwiftUI

/// A landscape media surface with artwork, metadata, and optional independent actions.
struct MediaCard<Background: ShapeStyle, Artwork: View, Metadata: View, Actions: View>: View {
    let background: Background
    @ViewBuilder let artwork: Artwork
    @ViewBuilder let metadata: Metadata
    @ViewBuilder let actions: Actions

    init(
        background: Background,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata,
        @ViewBuilder actions: () -> Actions
    ) {
        self.background = background
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = actions()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            artwork
            VStack(alignment: .leading, spacing: 0) {
                metadata
                actions
            }
            .padding(12)
        }
        .foregroundStyle(.white)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .contain)
    }
}

extension MediaCard where Actions == EmptyView {
    init(
        background: Background,
        @ViewBuilder artwork: () -> Artwork,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.background = background
        self.artwork = artwork()
        self.metadata = metadata()
        self.actions = EmptyView()
    }
}

#if DEBUG
#Preview("MediaCard — Variants") {
    VStack {
        MediaCard(background: .indigo.gradient) {
            Rectangle()
                .fill(.white.opacity(0.12))
                .aspectRatio(1.6, contentMode: .fit)
                .overlay { Image(systemName: "mic.fill") }
        } metadata: {
            VStack(alignment: .leading, spacing: 5) {
                Text("Today").font(.caption2).foregroundStyle(.white.opacity(0.72))
                Text("Daily Stories").font(.caption.weight(.semibold))
                Text("A Walk Through the City").font(.headline)
                Text("A reported story about how public spaces shape everyday life.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.78))
            }
        } actions: {
            HStack {
                PlaybackButton(label: "Play 24 min", accessibilityLabel: "Play A Walk Through the City, 24 min", action: {})
                    .tint(.white)
                Spacer()
                Button("More", systemImage: "ellipsis", action: {})
                    .labelStyle(.iconOnly)
            }
            .padding(.top, 3)
        }

        MediaCard(background: .teal.gradient) {
            Rectangle()
                .fill(.white.opacity(0.12))
                .aspectRatio(1.6, contentMode: .fit)
                .overlay { Image(systemName: "play.rectangle.fill") }
        } metadata: {
            VStack(alignment: .leading, spacing: 6) {
                Text("A New Series").font(.headline)
                Text("Hear the first moments of a thoughtful new conversation.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.78))
            }
        }
    }
    .padding()
    .frame(width: 402)
}

#Preview("MediaCard — Accessibility") {
    MediaCard(background: .blue.gradient) {
        Rectangle()
            .fill(.white.opacity(0.15))
            .aspectRatio(1.6, contentMode: .fit)
    } metadata: {
        Text("A long media title that demonstrates how metadata grows at accessibility sizes")
            .font(.headline)
    }
    .padding()
    .frame(width: 402)
    .dynamicTypeSize(.accessibility3)
}
#endif
