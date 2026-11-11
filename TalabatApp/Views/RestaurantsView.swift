import SwiftUI

struct RestaurantsView: View {
    @EnvironmentObject private var store: AppStore
    @State private var search = ""
    @State private var category = "All"
    @State private var showingSignOut = false
    private let categories = ["All", "Burgers", "Pizza", "Asian", "Café"]

    private var filtered: [Restaurant] {
        SampleData.restaurants.filter {
            (category == "All" || $0.cuisine == category) &&
            (search.isEmpty || "\($0.name) \($0.cuisine)".localizedCaseInsensitiveContains(search))
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Hello, \(store.displayName ?? "food lover") 👋").font(.subheadline).foregroundStyle(.secondary)
                    Text("What are you\ncraving today?")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                }
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("YOUR NEXT FAVOURITE").font(.caption2.bold()).tracking(1)
                        Text("Fresh bites.\nHappy days.").font(.title2.bold())
                        Text("Explore our demo menu").font(.caption)
                    }
                    Spacer()
                    Text("🥡").font(.system(size: 74)).accessibilityHidden(true)
                }
                .padding(22).frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .background(LinearGradient(colors: [Theme.orange, .orange], startPoint: .leading, endPoint: .bottomTrailing),
                            in: RoundedRectangle(cornerRadius: 24))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { value in
                            Button { category = value } label: {
                                Text(value).font(.subheadline.bold()).padding(.horizontal, 18).padding(.vertical, 12)
                                    .foregroundStyle(category == value ? Color.white : Color.primary)
                                    .background(category == value ? Theme.orange : Color(uiColor: .secondarySystemGroupedBackground), in: Capsule())
                            }.buttonStyle(.plain)
                                .accessibilityAddTraits(category == value ? .isSelected : [])
                        }
                    }
                }

                HStack {
                    Text("Made for your cravings").font(.title3.bold())
                    Spacer()
                    Text("\(filtered.count) places").font(.caption).foregroundStyle(.secondary)
                }
                if filtered.isEmpty {
                    ContentUnavailableView.search(text: search)
                }
                ForEach(filtered) { restaurant in
                    NavigationLink {
                        RestaurantDetailView(restaurant: restaurant)
                    } label: {
                        RestaurantCard(restaurant: restaurant)
                    }.buttonStyle(.plain)
                }
                DemoNotice()
            }.padding(20)
        }
        .background(Theme.background)
        .navigationTitle("Discover").navigationBarTitleDisplayMode(.inline)
        .searchable(text: $search, prompt: "Restaurant or cuisine")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Label("Dubai · Demo", systemImage: "location.fill").font(.caption.bold()).foregroundStyle(Theme.orange)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button { showingSignOut = true } label: { Image(systemName: "rectangle.portrait.and.arrow.right") }
                    .accessibilityLabel("Sign out")
            }
        }
        .alert("Sign out?", isPresented: $showingSignOut) {
            Button("Cancel", role: .cancel) { }
            Button("Sign out", role: .destructive) { store.signOut() }
        } message: { Text("Your demo basket will be cleared.") }
    }
}

struct RestaurantCard: View {
    let restaurant: Restaurant
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FoodArt(emoji: restaurant.emoji)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(restaurant.name).font(.title3.bold())
                    Spacer()
                    Label(restaurant.rating, systemImage: "star.fill").font(.caption.bold()).foregroundStyle(.orange)
                }
                Text(restaurant.tagline).font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 14) {
                    Text(restaurant.cuisine)
                    Label("\(restaurant.minutes) min", systemImage: "clock")
                    Spacer(minLength: 0)
                }.font(.caption).foregroundStyle(.secondary)
            }.padding(16)
        }
        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 22))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .accessibilityElement(children: .combine)
    }
}
