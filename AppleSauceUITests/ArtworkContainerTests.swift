import SwiftUI
import Testing
@testable import AppleSauceUI

@MainActor
struct ArtworkContainerTests {
    private let assetNames = [
        "MusicBlueHourArcade",
        "EpisodeCoastalTrail",
        "RegressionPortraitArtwork"
    ]

    @Test func videoLockupGeometryDoesNotDependOnBitmapDimensions() throws {
        let sizes = try assetNames.map(renderedVideoLockupSize)

        #expect(Set(sizes.map(\.width)) == [161])
        #expect(Set(sizes.map(\.height)).count == 1)
    }

    @Test func mediaCardArtworkGeometryDoesNotDependOnBitmapDimensions() throws {
        let sizes = try assetNames.map(renderedMediaCardSize)

        #expect(Set(sizes.map(\.width)) == [249])
        #expect(Set(sizes.map(\.height)).count == 1)
    }

    @Test func missingArtworkMatchesExplicitFallbackGeometry() throws {
        let missingArtwork = ArtworkImage(
            assetName: "AssetThatDoesNotExist",
            placeholderSymbol: "photo",
            placeholderBackground: AnyShapeStyle(.gray)
        )
        let explicitFallback = ArtworkImage(
            assetName: nil,
            placeholderSymbol: "photo",
            placeholderBackground: AnyShapeStyle(.gray)
        )

        #expect(try renderedSize(of: missingArtwork.frame(width: 120, height: 80)) == renderedSize(of: explicitFallback.frame(width: 120, height: 80)))
    }

    private func renderedVideoLockupSize(assetName: String) throws -> CGSize {
        let view = VideoLockup(title: "Fixture") {
            ArtworkImage(
                assetName: assetName,
                placeholderSymbol: "photo",
                placeholderBackground: AnyShapeStyle(.gray)
            )
        }
        .frame(width: 161)

        return try renderedSize(of: view)
    }

    private func renderedMediaCardSize(assetName: String) throws -> CGSize {
        let view = MediaCard(title: "Fixture") {
            ArtworkImage(
                assetName: assetName,
                placeholderSymbol: "photo",
                placeholderBackground: AnyShapeStyle(.gray)
            )
        }
        .frame(width: 249)

        return try renderedSize(of: view)
    }

    private func renderedSize<Content: View>(of content: Content) throws -> CGSize {
        let renderer = ImageRenderer(content: content)
        renderer.scale = 1
        return try #require(renderer.uiImage).size
    }
}
