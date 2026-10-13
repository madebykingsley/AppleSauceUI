import SwiftUI

enum PodcastShowLockupPresentation: Equatable {
    case standard
    case ranked(Int)
    case library
}

struct PodcastShowLockup: View {
    let show: PodcastShowFixture
    var presentation = PodcastShowLockupPresentation.standard

    var body: some View {
        SquareLockup(
            title: show.title,
            subtitle: subtitle,
            metadata: metadata,
            badge: show.badge?.compactText,
            badgeAccessibilityLabel: show.badge?.accessibilityName,
            style: style
        ) {
            ArtworkPlaceholder(symbol: show.symbol, background: AnyShapeStyle(show.color.gradient))
        }
    }

    private var subtitle: String? {
        switch presentation {
        case .standard:
            show.category
        case .ranked:
            show.publisher
        case .library:
            show.updateInformation
        }
    }

    private var metadata: String? {
        presentation == .standard ? show.updateInformation : nil
    }

    private var style: SquareLockupStyle {
        switch presentation {
        case .standard:
            .standard
        case .ranked(let rank):
            .ranked(rank)
        case .library:
            .library
        }
    }
}

#if DEBUG
#Preview("PodcastShowLockup — Variants") {
    HStack(alignment: .top) {
        PodcastShowLockup(show: PodcastsFixtures.homeTopShows[0])
        PodcastShowLockup(show: PodcastsFixtures.newTopShows[0], presentation: .ranked(1))
    }
    .padding()
}
#endif
