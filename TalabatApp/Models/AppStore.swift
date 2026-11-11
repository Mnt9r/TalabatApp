import Foundation
import Combine

@MainActor
final class AppStore: ObservableObject {
    @Published private(set) var displayName: String?
    @Published private(set) var cart: [CartLine] = []
    @Published var selectedTab = 0

    var isSignedIn: Bool { displayName != nil }
    var itemCount: Int { cart.reduce(0) { $0 + $1.quantity } }
    var subtotal: Int { cart.reduce(0) { $0 + $1.total } }
    var deliveryFee: Int { cart.isEmpty ? 0 : 7 }
    var total: Int { subtotal + deliveryFee }

    // Local prototype only: credentials are never stored or sent anywhere.
    func signIn(email: String, password: String) -> Bool {
        let cleaned = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = cleaned.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2, !parts[0].isEmpty, parts[1].contains("."),
              !cleaned.contains(where: { $0.isWhitespace }), password.count >= 6 else { return false }
        displayName = String(parts[0])
        return true
    }

    func continueAsGuest() { displayName = "Guest" }

    func signOut() {
        cart = []
        selectedTab = 0
        displayName = nil
    }

    func add(_ item: MenuItem, from restaurant: Restaurant) {
        if let index = cart.firstIndex(where: { $0.id == item.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartLine(item: item, restaurantName: restaurant.name, quantity: 1))
        }
    }

    func changeQuantity(id: String, by delta: Int) {
        guard let index = cart.firstIndex(where: { $0.id == id }) else { return }
        cart[index].quantity += delta
        if cart[index].quantity <= 0 { cart.remove(at: index) }
    }

    func quantity(for item: MenuItem) -> Int {
        cart.first(where: { $0.id == item.id })?.quantity ?? 0
    }

    func placeDemoOrder() -> DemoOrder? {
        guard !cart.isEmpty else { return nil }
        let order = DemoOrder(reference: "DEMO-" + String(UUID().uuidString.prefix(6)),
                              total: total, itemCount: itemCount)
        cart = []
        return order
    }
}
