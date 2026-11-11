import SwiftUI

@main
struct TalabatAppApp: App {
    @StateObject private var store = AppStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .tint(Theme.orange)
        }
    }
}
