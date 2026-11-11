import Foundation
import CoreLocation

struct MenuItem: Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let price: Int // AED, whole dirhams in this demo
    let emoji: String
}

struct Restaurant: Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let tagline: String
    let rating: String
    let minutes: String
    let emoji: String
    let address: String
    let latitude: Double
    let longitude: Double
    let menu: [MenuItem]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct CartLine: Identifiable {
    let item: MenuItem
    let restaurantName: String
    var quantity: Int
    var id: String { item.id }
    var total: Int { item.price * quantity }
}

struct DemoOrder {
    let reference: String
    let total: Int
    let itemCount: Int
}

enum SampleData {
    // Fictional businesses. Coordinates are illustrative locations in Dubai.
    static let restaurants: [Restaurant] = [
        Restaurant(id: "ember", name: "Ember Burger", cuisine: "Burgers",
                   tagline: "Big flavour. Fresh off the grill.", rating: "4.8", minutes: "20–30", emoji: "🍔",
                   address: "Demo location · Downtown Dubai", latitude: 25.1951, longitude: 55.2784,
                   menu: [
                    MenuItem(id: "ember-classic", name: "The Classic", description: "Grilled beef, cheddar, lettuce and house sauce.", price: 32, emoji: "🍔"),
                    MenuItem(id: "ember-chicken", name: "Crispy Chicken", description: "Crispy chicken, slaw and a little heat.", price: 29, emoji: "🥪"),
                    MenuItem(id: "ember-fries", name: "Golden Fries", description: "Crispy fries with sea salt.", price: 12, emoji: "🍟")
                   ]),
        Restaurant(id: "napoli", name: "Napoli Slice", cuisine: "Pizza",
                   tagline: "A little slice of happiness.", rating: "4.7", minutes: "25–35", emoji: "🍕",
                   address: "Demo location · Business Bay, Dubai", latitude: 25.1850, longitude: 55.2630,
                   menu: [
                    MenuItem(id: "napoli-margherita", name: "Margherita", description: "Tomato, mozzarella and fresh basil.", price: 38, emoji: "🍕"),
                    MenuItem(id: "napoli-pepperoni", name: "Pepperoni", description: "Beef pepperoni, mozzarella and tomato sauce.", price: 44, emoji: "🍕"),
                    MenuItem(id: "napoli-salad", name: "Garden Salad", description: "Mixed leaves, cucumber and lemon dressing.", price: 18, emoji: "🥗")
                   ]),
        Restaurant(id: "sakura", name: "Sakura Kitchen", cuisine: "Asian",
                   tagline: "Your next favourite comfort bowl.", rating: "4.9", minutes: "30–40", emoji: "🍜",
                   address: "Demo location · DIFC, Dubai", latitude: 25.2110, longitude: 55.2800,
                   menu: [
                    MenuItem(id: "sakura-noodles", name: "Chicken Noodles", description: "Wok-tossed noodles, chicken and vegetables.", price: 36, emoji: "🍜"),
                    MenuItem(id: "sakura-rice", name: "Teriyaki Bowl", description: "Teriyaki chicken over steamed rice.", price: 39, emoji: "🍚"),
                    MenuItem(id: "sakura-rolls", name: "Vegetable Rolls", description: "Four crispy rolls with sweet chilli dip.", price: 16, emoji: "🥟")
                   ]),
        Restaurant(id: "bloom", name: "Bloom Café", cuisine: "Café",
                   tagline: "Good coffee. Better mornings.", rating: "4.6", minutes: "15–25", emoji: "☕️",
                   address: "Demo location · City Walk, Dubai", latitude: 25.2060, longitude: 55.2610,
                   menu: [
                    MenuItem(id: "bloom-latte", name: "Iced Latte", description: "Espresso, milk and ice. Simply refreshing.", price: 22, emoji: "🧋"),
                    MenuItem(id: "bloom-croissant", name: "Butter Croissant", description: "Flaky, golden and baked fresh.", price: 16, emoji: "🥐"),
                    MenuItem(id: "bloom-toast", name: "Avocado Toast", description: "Sourdough, avocado and cherry tomatoes.", price: 30, emoji: "🥑")
                   ])
    ]
}
