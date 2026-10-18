import SwiftUI

#if DEBUG
struct ComparisonControls: View {
    @Binding var mode: ComparisonMode
    @Binding var referenceOpacity: Double
    @Binding var differenceIntensity: Double
    @Binding var showsGrid: Bool
    @Binding var showsSafeArea: Bool
    @Binding var showsCenterLines: Bool
    @Binding var showsEdgeGuides: Bool

    let spec: ReferenceSpec
    let refreshDifference: () -> Void

    @State private var isExpanded = false
    @State private var positionOffset = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Visual Comparison", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .gesture(panelDragGesture)
                    .onTapGesture(count: 2, perform: resetPosition)
                    .accessibilityHint("Drag to move the panel.")

                Spacer(minLength: 8)

                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isExpanded ? "Collapse controls" : "Expand controls")

                Button("Reset panel position", systemImage: "arrow.counterclockwise", action: resetPosition)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
            }

            Picker("Comparison mode", selection: $mode) {
                ForEach(ComparisonMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            if isExpanded {
                if mode == .overlay {
                    ViewThatFits(in: .horizontal) {
                        HStack {
                            Text("Reference opacity")
                            Slider(value: $referenceOpacity, in: 0...1)
                            Text(referenceOpacity, format: .percent.precision(.fractionLength(0)))
                                .monospacedDigit()
                                .frame(minWidth: 44, alignment: .trailing)
                        }

                        VStack(alignment: .leading) {
                            Text("Reference opacity")
                            HStack {
                                Slider(value: $referenceOpacity, in: 0...1)
                                Text(referenceOpacity, format: .percent.precision(.fractionLength(0)))
                                    .monospacedDigit()
                                    .frame(minWidth: 44, alignment: .trailing)
                            }
                        }
                    }
                }

                if mode == .difference {
                    ViewThatFits(in: .horizontal) {
                        HStack {
                            Text("Difference intensity")
                            Slider(value: $differenceIntensity, in: 0...1)
                            Text(differenceIntensity, format: .percent.precision(.fractionLength(0)))
                                .monospacedDigit()
                                .frame(minWidth: 44, alignment: .trailing)
                        }

                        VStack(alignment: .leading) {
                            Text("Difference intensity")
                            HStack {
                                Slider(value: $differenceIntensity, in: 0...1)
                                Text(differenceIntensity, format: .percent.precision(.fractionLength(0)))
                                    .monospacedDigit()
                                    .frame(minWidth: 44, alignment: .trailing)
                            }
                        }
                    }

                    Button("Refresh Difference", systemImage: "arrow.clockwise") {
                        refreshDifference()
                    }
                }

                ViewThatFits {
                    HStack {
                        overlayToggles
                    }

                    VStack(alignment: .leading) {
                        overlayToggles
                    }
                }

                Text("\(spec.device.rawValue) · \(spec.orientation.rawValue) · \(spec.colorScheme == .dark ? "Dark" : "Light")")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if let notes = spec.notes {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(radius: 12)
        .padding(12)
        .offset(
            x: positionOffset.width + dragOffset.width,
            y: positionOffset.height + dragOffset.height
        )
    }

    private var panelDragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                positionOffset.width += value.translation.width
                positionOffset.height += value.translation.height
            }
    }

    private func resetPosition() {
        withAnimation(.snappy) {
            positionOffset = .zero
        }
    }

    @ViewBuilder
    private var overlayToggles: some View {
        Toggle("8 pt grid", isOn: $showsGrid)
        Toggle("Safe area", isOn: $showsSafeArea)
        Toggle("Centers", isOn: $showsCenterLines)
        Toggle("Edges", isOn: $showsEdgeGuides)
    }
}
#endif
