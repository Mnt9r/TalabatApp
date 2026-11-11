import SwiftUI

enum Theme {
    static let orange = Color(red: 0.94, green: 0.29, blue: 0.09)
    static let background = Color(uiColor: .systemGroupedBackground)
    static let peach = Color(red: 1, green: 0.91, blue: 0.83)
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.headline)
            .frame(maxWidth: .infinity).padding(.vertical, 17)
            .foregroundStyle(.white)
            .background(Theme.orange.opacity(configuration.isPressed ? 0.75 : 1), in: RoundedRectangle(cornerRadius: 18))
    }
}

struct FoodArt: View {
    let emoji: String
    var large = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [Theme.peach, Color(red: 1, green: 0.80, blue: 0.62)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle().fill(.white.opacity(0.3)).frame(width: large ? 210 : 130)
                .offset(x: 70, y: -25)
            Circle().stroke(.white.opacity(0.35), lineWidth: 1).frame(width: large ? 250 : 170)
                .offset(x: -85, y: 45)
            Text(emoji).font(.system(size: large ? 100 : 70))
                .rotationEffect(.degrees(-10)).shadow(color: .brown.opacity(0.12), radius: 8, y: 8)
        }
        .frame(height: large ? 240 : 160).clipped().accessibilityHidden(true)
    }
}

struct DemoNotice: View {
    var text = "Sample restaurants and locations for a student project."
    var body: some View {
        Label(text, systemImage: "info.circle")
            .font(.caption).foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}
