import XCTest
@testable import TalabatApp

@MainActor
final class AppStoreTests: XCTestCase {
    func testDemoSignInValidationAndSignOut() {
        let store = AppStore()
        XCTAssertFalse(store.signIn(email: "bad-email", password: "123456"))
        XCTAssertFalse(store.signIn(email: "demo@example.com", password: "123"))
        XCTAssertFalse(store.isSignedIn)
        XCTAssertTrue(store.signIn(email: " demo@example.com ", password: "123456"))
        XCTAssertEqual(store.displayName, "demo")
        let restaurant = SampleData.restaurants[0]
        store.add(restaurant.menu[0], from: restaurant)
        store.selectedTab = 2
        store.signOut()
        XCTAssertFalse(store.isSignedIn)
        XCTAssertTrue(store.cart.isEmpty)
        XCTAssertEqual(store.selectedTab, 0)
    }

    func testCartQuantitiesTotalsAndRemoval() {
        let store = AppStore()
        let restaurant = SampleData.restaurants[0]
        let burger = restaurant.menu[0]
        let fries = restaurant.menu[2]
        XCTAssertEqual(store.total, 0)
        store.add(burger, from: restaurant)
        store.add(burger, from: restaurant)
        store.add(fries, from: restaurant)
        XCTAssertEqual(store.cart.count, 2)
        XCTAssertEqual(store.itemCount, 3)
        XCTAssertEqual(store.subtotal, 76)
        XCTAssertEqual(store.total, 83)
        store.changeQuantity(id: burger.id, by: -1)
        XCTAssertEqual(store.quantity(for: burger), 1)
        store.changeQuantity(id: burger.id, by: -1)
        XCTAssertEqual(store.quantity(for: burger), 0)
        XCTAssertEqual(store.subtotal, 12)
        store.changeQuantity(id: fries.id, by: -1)
        XCTAssertEqual(store.deliveryFee, 0)
        XCTAssertEqual(store.total, 0)
        store.changeQuantity(id: "missing", by: -1)
        XCTAssertTrue(store.cart.isEmpty)
    }

    func testOrderCapturesTotalAndClearsCart() {
        let store = AppStore()
        XCTAssertNil(store.placeDemoOrder())
        let restaurant = SampleData.restaurants[0]
        store.add(restaurant.menu[0], from: restaurant)
        let order = store.placeDemoOrder()
        XCTAssertEqual(order?.total, 39)
        XCTAssertEqual(order?.itemCount, 1)
        XCTAssertTrue(order?.reference.hasPrefix("DEMO-") == true)
        XCTAssertTrue(store.cart.isEmpty)
        XCTAssertEqual(store.total, 0)
    }

    func testSampleIDsAreUniqueAndCoordinatesValid() {
        let restaurants = SampleData.restaurants
        XCTAssertEqual(Set(restaurants.map(\.id)).count, restaurants.count)
        let items = restaurants.flatMap(\.menu)
        XCTAssertEqual(Set(items.map(\.id)).count, items.count)
        for restaurant in restaurants {
            XCTAssertTrue((-90...90).contains(restaurant.latitude))
            XCTAssertTrue((-180...180).contains(restaurant.longitude))
            XCTAssertFalse(restaurant.menu.isEmpty)
        }
        XCTAssertTrue(items.allSatisfy { $0.price > 0 })
    }
}
