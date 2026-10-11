import SwiftUI

struct DebugGridOverlay: View {
    let showsGrid: Bool
    let showsSafeArea: Bool
    let showsCenterLines: Bool
    let showsEdgeGuides: Bool

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if showsGrid {
                    GridCanvas()
                }

                if showsSafeArea {
                    SafeAreaBoundary(
                        size: proxy.size,
                        insets: proxy.safeAreaInsets
                    )
                }

                if showsCenterLines {
                    CenterLines(size: proxy.size)
                }

                if showsEdgeGuides {
                    EdgeGuides(size: proxy.size)
                }
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

private struct GridCanvas: View {
    var body: some View {
        Canvas { context, size in
            var path = Path()

            for x in stride(from: CGFloat.zero, through: size.width, by: 8) {
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }

            for y in stride(from: CGFloat.zero, through: size.height, by: 8) {
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }

            context.stroke(path, with: .color(.cyan.opacity(0.28)), lineWidth: 0.5)
        }
    }
}

private struct SafeAreaBoundary: View {
    let size: CGSize
    let insets: EdgeInsets

    var body: some View {
        Path { path in
            path.addRect(
                CGRect(
                    x: insets.leading,
                    y: insets.top,
                    width: max(0, size.width - insets.leading - insets.trailing),
                    height: max(0, size.height - insets.top - insets.bottom)
                )
            )
        }
        .stroke(.yellow, style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
    }
}

private struct CenterLines: View {
    let size: CGSize

    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: size.width / 2, y: 0))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            path.move(to: CGPoint(x: 0, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width, y: size.height / 2))
        }
        .stroke(Color(red: 1, green: 0, blue: 0.8).opacity(0.85), lineWidth: 1)
    }
}

private struct EdgeGuides: View {
    let size: CGSize

    var body: some View {
        Path { path in
            for inset in [CGFloat(8), 16, 20] {
                path.addRect(
                    CGRect(
                        x: inset,
                        y: inset,
                        width: max(0, size.width - inset * 2),
                        height: max(0, size.height - inset * 2)
                    )
                )
            }
        }
        .stroke(.orange.opacity(0.8), style: StrokeStyle(lineWidth: 0.75, dash: [3, 3]))
    }
}
