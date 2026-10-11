import SwiftUI

/// A consistently sized account action whose visual identity remains caller-owned.
struct AccountButton<Avatar: View>: View {
    let action: () -> Void
    @ViewBuilder let avatar: Avatar

    var body: some View {
        Button(action: action) {
            avatar
                .frame(width: 40, height: 40)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Account")
    }
}

#if DEBUG
#Preview("AccountButton — Variants") {
    AccountButton(action: {}) {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .symbolRenderingMode(.hierarchical)
    }
    .padding()
}
#endif
