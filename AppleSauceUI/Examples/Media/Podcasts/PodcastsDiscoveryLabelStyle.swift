import SwiftUI

struct PodcastsDiscoveryLabelStyle: LabelStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: spacing) {
            configuration.icon
                .font(.title)
                .opacity(0.28)
            configuration.title
                .font(.headline)
                .bold()
        }
    }
}
