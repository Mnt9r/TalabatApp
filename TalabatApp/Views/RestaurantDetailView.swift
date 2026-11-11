import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @EnvironmentObject private var store: AppStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                FoodArt(emoji: restaurant.emoji, large: true)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                VStack(alignment: .leading, spacing: 10) {
                    Text(restaurant.name).font(.largeTitle.bold())
                    Text(restaurant.tagline).foregroundStyle(.secondary)
                    HStack(spacing: 18) {
                        Label(restaurant.rating, systemImage: "star.fill").foregroundStyle(.orange)
                        Label("\(restaurant.minutes) min", systemImage: "clock")
                        Text(restaurant.cuisine)
                    }.font(.subheadline)
                    NavigationLink {
                        LocationsView(initialRestaurantID: restaurant.id)
                    } label: {
                        Label(restaurant.address, systemImage: "mappin.and.ellipse")
                            .font(.subheadline).padding(.vertical, 8)
                    }
                }
                HStack {
                    Text("The menu").font(.title2.bold())
                    Spacer()
                    Text("Prices in AED").font(.caption).foregroundStyle(.secondary)
                }
                ForEach(restaurant.menu) { item in
                    HStack(alignment: .top, spacing: 14) {
                        Text(item.emoji).font(.system(size: 40))
                            .frame(width: 70, height: 80)
                            .background(Theme.peach, in: RoundedRectangle(cornerRadius: 16))
                            .accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: 7) {
                            Text(item.name).font(.headline)
                            Text(item.description).font(.caption).foregroundStyle(.secondary)
                            HStack {
                                Text("AED \(item.price)").font(.subheadline.bold())
                                Spacer()
                                Button { store.add(item, from: restaurant) } label: {
                                    HStack(spacing: 5) {
                                        Image(systemName: "plus")
                                        Text(store.quantity(for: item) > 0 ? "Add (\(store.quantity(for: item)))" : "Add")
                                    }.font(.caption.bold()).padding(.horizontal, 12).frame(minHeight: 44)
                                        .foregroundStyle(Theme.orange).background(Theme.peach, in: Capsule())
                                }.buttonStyle(.plain).accessibilityLabel("Add \(item.name) to cart")
                            }
                        }
                    }
                    .padding(16).background(Color(uiColor: .secondarySystemGroupedBackground),
                                             in: RoundedRectangle(cornerRadius: 20))
                }
                DemoNotice(text: "Menu items, ratings and delivery times are sample data.")
            }.padding(20)
        }
        .background(Theme.background)
        .navigationTitle(restaurant.name).navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            if store.itemCount > 0 {
                Button {
                    store.selectedTab = 2
                } label: {
                    HStack {
                        Label("View cart · \(store.itemCount)", systemImage: "bag.fill")
                        Spacer()
                        Text("AED \(store.subtotal)")
                    }.padding(.horizontal, 16)
                }
                .buttonStyle(PrimaryButtonStyle()).padding(16).background(.bar)
            }
        }
    }
}
