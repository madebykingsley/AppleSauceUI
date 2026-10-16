import SwiftUI

/// Bitmap artwork loaded from the asset catalog with a generated fallback.
struct ArtworkImage: View {
    let assetName: String?
    let placeholderSymbol: String
    let placeholderBackground: AnyShapeStyle
    var contentMode: ContentMode = .fill
    var placeholderSymbolPadding: CGFloat = 38

    var body: some View {
        if let assetName {
            Image(assetName)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .accessibilityHidden(true)
        } else {
            ArtworkPlaceholder(
                symbol: placeholderSymbol,
                background: placeholderBackground,
                symbolPadding: placeholderSymbolPadding
            )
        }
    }
}

#if DEBUG
#Preview("ArtworkImage — Variants") {
    HStack {
        ArtworkImage(assetName: "MusicNightTrain", placeholderSymbol: "music.note", placeholderBackground: AnyShapeStyle(.indigo.gradient))
        ArtworkImage(assetName: "MissingArtwork", placeholderSymbol: "photo", placeholderBackground: AnyShapeStyle(.gray.gradient))
    }
    .frame(width: 360, height: 170)
    .padding()
}
#endif
