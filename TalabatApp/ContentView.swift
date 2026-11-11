import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        Group {
            if store.isSignedIn {
                TabView(selection: $store.selectedTab) {
                    NavigationStack { RestaurantsView() }
                        .tabItem { Label("Discover", systemImage: "square.grid.2x2.fill") }.tag(0)
                    NavigationStack { LocationsView() }
                        .tabItem { Label("Locations", systemImage: "map.fill") }.tag(1)
                    NavigationStack { CartView() }
                        .tabItem { Label("Cart", systemImage: "bag.fill") }
                        .badge(store.itemCount).tag(2)
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview { ContentView().environmentObject(AppStore()) }
