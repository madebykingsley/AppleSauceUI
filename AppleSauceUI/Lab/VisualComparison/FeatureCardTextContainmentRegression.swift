import SwiftUI

#if DEBUG
struct FeatureCardTextContainmentRegression: View {
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
                Text("Feature card containment")
                    .font(.title2.bold())

                MediaCard(
                    background: Color.indigo.gradient,
                    artworkGeometry: .aspectRatio(1.6)
                ) {
                    ArtworkImage(
                        assetName: "EpisodeCoastalTrail",
                        placeholderSymbol: "photo",
                        placeholderBackground: AnyShapeStyle(.indigo.gradient)
                    )
                } metadata: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("FEATURED CONVERSATION")
                            .font(.caption)
                        Text("How coastal communities preserve their history while preparing for an uncertain future")
                            .font(.headline)
                        Text("A long supporting description exercises readable copy without allowing decorative artwork to determine the text region’s height.")
                            .font(.body)
                    }
                } actions: {
                    HStack {
                        Button("Play episode", systemImage: "play.fill", action: {})
                        Spacer()
                        Button("More options", systemImage: "ellipsis", action: {})
                            .labelStyle(.iconOnly)
                    }
                    .padding(.top, 12)
                }

                Text("Following section")
                    .font(.headline)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .frame(width: width)
    }
}

#Preview("Feature Card Text Containment — Standard", traits: .sizeThatFitsLayout) {
    FeatureCardTextContainmentRegression(width: 390)
}

#Preview("Feature Card Text Containment — Accessibility Narrow", traits: .sizeThatFitsLayout) {
    FeatureCardTextContainmentRegression(width: 320)
        .dynamicTypeSize(.accessibility1)
}
#endif
