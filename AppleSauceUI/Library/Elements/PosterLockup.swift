import SwiftUI

/// A portrait, full-bleed artwork presentation used by featured media.
struct PosterLockup<Artwork: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    let title: String
    var eyebrow: String?
    let subtitle: String
    let height: CGFloat
    @ViewBuilder let artwork: Artwork

    var body: some View {
        ZStack {
            artwork
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.largeTitle.weight(.semibold))
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack(alignment: .leading, spacing: 3) {
                    if let eyebrow, !eyebrow.isEmpty {
                        Text(eyebrow)
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.72))
                    }
                    Text(subtitle)
                        .font(.footnote)
                        .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)
                }
            }
            .padding(17)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: dynamicTypeSize.isAccessibilitySize ? nil : height, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("PosterLockup — Variants") {
    PosterLockup(title: "Featured Mix", eyebrow: "Made for You", subtitle: "A collection selected for today", height: 330) {
        Rectangle().fill(.blue.gradient)
    }
    .frame(width: 248)
    .padding()
}


#Preview("PosterLockup — Accessibility") {
    PosterLockup(title: "A Featured Collection With a Long Title", eyebrow: "Made for You", subtitle: "A collection selected for today", height: 330) {
        Rectangle().fill(.blue.gradient)
    }
    .frame(width: 248)
    .padding()
    .dynamicTypeSize(.accessibility3)
}
#endif
