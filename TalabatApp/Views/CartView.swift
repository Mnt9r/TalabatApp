import SwiftUI

struct CartView: View {
    @EnvironmentObject private var store: AppStore
    @State private var order: DemoOrder?
    @State private var showingConfirmation = false
    @State private var showingSuccess = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("Your happy bag").font(.largeTitle.bold())
                if store.cart.isEmpty {
                    ContentUnavailableView {
                        Label("Something tasty is missing", systemImage: "bag")
                    } description: {
                        Text("Find a favourite restaurant and add your first bite.")
                    } actions: {
                        Button("Discover restaurants") { store.selectedTab = 0 }
                            .buttonStyle(.borderedProminent).controlSize(.large)
                    }
                } else {
                    ForEach(store.cart) { line in
                        HStack(alignment: .top, spacing: 14) {
                            Text(line.item.emoji).font(.largeTitle).frame(width: 56, height: 64)
                                .background(Theme.peach, in: RoundedRectangle(cornerRadius: 14))
                            VStack(alignment: .leading, spacing: 6) {
                                Text(line.item.name).font(.headline)
                                Text(line.restaurantName).font(.caption).foregroundStyle(.secondary)
                                HStack {
                                    Text("AED \(line.total)").font(.subheadline.bold())
                                    Spacer()
                                    quantityControl(line)
                                }
                            }
                        }.padding(16).background(Color(uiColor: .secondarySystemGroupedBackground),
                                                 in: RoundedRectangle(cornerRadius: 20))
                    }
                    VStack(spacing: 16) {
                        summaryRow("Subtotal", amount: store.subtotal)
                        summaryRow("Demo delivery fee", amount: store.deliveryFee)
                        Divider()
                        summaryRow("Total", amount: store.total).fontWeight(.bold)
                    }.padding(20).background(Color(uiColor: .secondarySystemGroupedBackground),
                                              in: RoundedRectangle(cornerRadius: 20))
                    Label("Dubai · Sample delivery area", systemImage: "location.fill")
                        .font(.subheadline).foregroundStyle(.secondary)
                    DemoNotice(text: "This is a simulated order. No payment is taken and no food is delivered. A flat AED 7 demo fee covers the entire basket.")
                }
            }.padding(20)
        }
        .background(Theme.background)
        .navigationTitle("Your cart").navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            if !store.cart.isEmpty {
                Button("Place demo order · AED \(store.total)") { showingConfirmation = true }
                    .buttonStyle(PrimaryButtonStyle()).padding(16).background(.bar)
            }
        }
        .confirmationDialog("Place this demo order?", isPresented: $showingConfirmation, titleVisibility: .visible) {
            Button("Confirm demo order") {
                order = store.placeDemoOrder()
                showingSuccess = order != nil
            }
        } message: { Text("No real order or payment will be made.") }
        .alert("Demo order complete!", isPresented: $showingSuccess) {
            Button("Keep exploring") { store.selectedTab = 0; order = nil }
        } message: {
            if let order {
                Text("\(order.reference)\n\(order.itemCount) items · AED \(order.total)\nThis was a simulation. No payment or delivery.")
            }
        }
    }

    private func summaryRow(_ title: String, amount: Int) -> some View {
        HStack { Text(title); Spacer(); Text("AED \(amount)") }
    }

    private func quantityControl(_ line: CartLine) -> some View {
        HStack(spacing: 0) {
            Button { store.changeQuantity(id: line.id, by: -1) } label: {
                Image(systemName: line.quantity == 1 ? "trash" : "minus").frame(width: 44, height: 44)
            }.accessibilityLabel("Decrease \(line.item.name) quantity")
            Text("\(line.quantity)").font(.subheadline.bold()).frame(minWidth: 22)
                .accessibilityLabel("Quantity \(line.quantity)")
            Button { store.changeQuantity(id: line.id, by: 1) } label: {
                Image(systemName: "plus").frame(width: 44, height: 44)
            }.accessibilityLabel("Increase \(line.item.name) quantity")
        }.background(Theme.peach, in: Capsule()).buttonStyle(.plain).foregroundStyle(Theme.orange)
    }
}
