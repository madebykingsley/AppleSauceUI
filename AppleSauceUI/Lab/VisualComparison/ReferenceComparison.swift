import SwiftUI
import UIKit

@MainActor
@Observable
final class VisualComparisonScrollState {
    var yOffset: CGFloat = 0
}

private struct VisualComparisonScrollStateKey: EnvironmentKey {
    static let defaultValue: VisualComparisonScrollState? = nil
}

private struct VisualComparisonLiveContentActiveKey: EnvironmentKey {
    static let defaultValue = true
}

extension EnvironmentValues {
    var visualComparisonScrollState: VisualComparisonScrollState? {
        get { self[VisualComparisonScrollStateKey.self] }
        set { self[VisualComparisonScrollStateKey.self] = newValue }
    }

    fileprivate var visualComparisonLiveContentActive: Bool {
        get { self[VisualComparisonLiveContentActiveKey.self] }
        set { self[VisualComparisonLiveContentActiveKey.self] = newValue }
    }
}

extension View {
    func visualComparisonScrollTracking() -> some View {
        modifier(VisualComparisonScrollTrackingModifier())
    }
}

private struct VisualComparisonScrollTrackingModifier: ViewModifier {
    @Environment(\.visualComparisonLiveContentActive) private var isLiveContentActive
    @Environment(\.visualComparisonScrollState) private var scrollState
    @State private var position = ScrollPosition()
    @State private var isTracking = false

    func body(content: Content) -> some View {
        content
            .scrollPosition($position)
            .task(id: isLiveContentActive) {
                isTracking = false

                guard isLiveContentActive, let scrollState else {
                    return
                }

                let savedOffset = scrollState.yOffset
                await Task.yield()
                position.scrollTo(y: savedOffset)
                await Task.yield()
                isTracking = true
            }
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                max(0, geometry.contentOffset.y + geometry.contentInsets.top)
            } action: { _, newOffset in
                if isLiveContentActive, isTracking {
                    scrollState?.yOffset = newOffset
                }
            }
    }
}

struct ReferenceComparison<Content: View>: View {
    let spec: ReferenceSpec
    private let content: Content

    init(
        spec: ReferenceSpec,
        @ViewBuilder content: () -> Content
    ) {
        self.spec = spec
        self.content = content()
    }

    init(
        referenceID: String,
        @ViewBuilder content: () -> Content
    ) {
        self.init(spec: ReferenceSpec(id: referenceID), content: content)
    }

    var body: some View {
        #if DEBUG
        ComparisonWorkspace(spec: spec, content: content)
        #else
        content
        #endif
    }
}

#if DEBUG
private struct ComparisonWorkspace<Content: View>: View {
    let spec: ReferenceSpec
    let content: Content

    @Environment(\.displayScale) private var displayScale
    @State private var mode = ComparisonMode.actual
    @State private var referenceOpacity = 0.5
    @State private var differenceIntensity = 0.35
    @State private var showsGrid = false
    @State private var showsSafeArea = false
    @State private var showsCenterLines = false
    @State private var showsEdgeGuides = false
    @State private var differenceImage: UIImage?
    @State private var comparisonSize = CGSize.zero
    @State private var scrollState = VisualComparisonScrollState()

    private let isCaptureMode = ProcessInfo.processInfo.arguments.contains("--visual-comparison-capture")

    private var referenceImage: UIImage? {
        spec.loadImage()
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                ComparisonCanvas(
                    mode: mode,
                    content: content,
                    referenceImage: referenceImage,
                    differenceImage: differenceImage,
                    referenceOpacity: referenceOpacity,
                    differenceIntensity: differenceIntensity,
                    scrollState: scrollState
                )
                .environment(\.colorScheme, spec.colorScheme)
                .environment(\.dynamicTypeSize, spec.dynamicTypeSize)
                .environment(\.visualComparisonScrollState, scrollState)
                .overlay {
                    DebugGridOverlay(
                        showsGrid: showsGrid,
                        showsSafeArea: showsSafeArea,
                        showsCenterLines: showsCenterLines,
                        showsEdgeGuides: showsEdgeGuides
                    )
                }

                if !isCaptureMode {
                    ComparisonControls(
                        mode: $mode,
                        referenceOpacity: $referenceOpacity,
                        differenceIntensity: $differenceIntensity,
                        showsGrid: $showsGrid,
                        showsSafeArea: $showsSafeArea,
                        showsCenterLines: $showsCenterLines,
                        showsEdgeGuides: $showsEdgeGuides,
                        spec: spec,
                        refreshDifference: renderDifference
                    )
                    .padding(.bottom, proxy.safeAreaInsets.bottom)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .onAppear {
                updateComparisonSize(for: proxy.size)
                renderDifferenceIfNeeded()
            }
            .onChange(of: proxy.size) { _, newSize in
                updateComparisonSize(for: newSize)
                renderDifferenceIfNeeded()
            }
            .onChange(of: mode) {
                renderDifferenceIfNeeded()
            }
        }
        .ignoresSafeArea(.container, edges: .all)
    }

    private func renderDifferenceIfNeeded() {
        guard mode == .difference else {
            return
        }
        renderDifference()
    }

    private func updateComparisonSize(for viewportSize: CGSize) {
        guard let referenceImage else {
            comparisonSize = viewportSize
            return
        }

        let fittedHeight = viewportSize.width * referenceImage.size.height / referenceImage.size.width
        comparisonSize = CGSize(
            width: viewportSize.width,
            height: max(viewportSize.height, fittedHeight)
        )
    }

    private func renderDifference() {
        guard let referenceImage else {
            differenceImage = nil
            return
        }

        let referencePixelWidth = CGFloat(referenceImage.cgImage?.width ?? 0)
        let referenceScale = referencePixelWidth > 0
            ? referencePixelWidth / comparisonSize.width
            : displayScale

        differenceImage = DifferenceRenderer.render(
            content: content,
            reference: referenceImage,
            size: comparisonSize,
            scale: referenceScale,
            colorScheme: spec.colorScheme,
            dynamicTypeSize: spec.dynamicTypeSize
        )
    }
}

private struct ComparisonCanvas<Content: View>: View {
    let mode: ComparisonMode
    let content: Content
    let referenceImage: UIImage?
    let differenceImage: UIImage?
    let referenceOpacity: Double
    let differenceIntensity: Double
    let scrollState: VisualComparisonScrollState

    var body: some View {
        ZStack(alignment: .top) {
            content
                .saturation(mode == .difference ? 0.7 : 1)
                .opacity(mode == .reference ? 0 : 1)
                .allowsHitTesting(mode != .reference)
                .accessibilityHidden(mode == .reference)
                .disabled(mode == .reference)
                .environment(\.visualComparisonLiveContentActive, mode != .reference)

            if mode == .overlay {
                ViewportComparisonImage(
                    image: referenceImage,
                    yOffset: scrollState.yOffset
                )
                .opacity(referenceOpacity)
                .allowsHitTesting(false)
            }

            if mode == .difference {
                ViewportComparisonImage(
                    image: differenceImage,
                    yOffset: scrollState.yOffset,
                    backgroundColor: .black
                )
                .opacity(differenceIntensity)
                .allowsHitTesting(false)
            }

            if mode == .reference {
                ReferenceScrollView(
                    image: referenceImage,
                    scrollState: scrollState
                )
            }
        }
        .clipped()
    }
}

private struct ReferenceScrollView: View {
    let image: UIImage?
    let scrollState: VisualComparisonScrollState

    @State private var position = ScrollPosition()
    @State private var isTracking = false

    var body: some View {
        ScrollView(.vertical) {
            ReferenceImageView(image: image)
        }
        .scrollPosition($position)
        .scrollIndicators(.visible)
        .task {
            let savedOffset = scrollState.yOffset
            await Task.yield()
            position.scrollTo(y: savedOffset)
            await Task.yield()
            isTracking = true
        }
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            max(0, geometry.contentOffset.y + geometry.contentInsets.top)
        } action: { _, newOffset in
            if isTracking {
                scrollState.yOffset = newOffset
            }
        }
    }
}

private struct ViewportComparisonImage: View {
    let image: UIImage?
    let yOffset: CGFloat
    var backgroundColor = Color.clear

    var body: some View {
        GeometryReader { proxy in
            if let image {
                let imageHeight = proxy.size.width * image.size.height / image.size.width

                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width, height: imageHeight)
                    .background(backgroundColor)
                    .offset(y: -yOffset)
                    .frame(maxHeight: .infinity, alignment: .top)
            } else {
                MissingReferenceView()
            }
        }
    }
}

private struct ReferenceImageView: View {
    let image: UIImage?

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            MissingReferenceView()
        }
    }
}

private struct MissingReferenceView: View {
    var body: some View {
        ContentUnavailableView(
            "Reference Image Missing",
            systemImage: "photo.badge.exclamationmark",
            description: Text("Add reference.png for this semantic reference ID to Lab/References.")
        )
        .background(Color(uiColor: .systemBackground))
    }
}
#endif
