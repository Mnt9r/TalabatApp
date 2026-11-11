import SwiftUI
import MapKit

struct LocationsView: View {
    var initialRestaurantID: String?
    @State private var selectedID: String?
    @State private var camera: MapCameraPosition = .region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.198, longitude: 55.274),
                           span: MKCoordinateSpan(latitudeDelta: 0.055, longitudeDelta: 0.055)))

    private var selectedRestaurant: Restaurant? {
        SampleData.restaurants.first { $0.id == selectedID }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Great food, nearby.").font(.largeTitle.bold())
                    Text("Tap a pin or choose a place below.").foregroundStyle(.secondary)
                }
                Map(position: $camera, selection: $selectedID) {
                    ForEach(SampleData.restaurants) { restaurant in
                        Marker(restaurant.name, systemImage: "fork.knife", coordinate: restaurant.coordinate)
                            .tint(Theme.orange).tag(restaurant.id)
                    }
                }
                .mapControls { MapCompass(); MapScaleView() }
                .frame(height: 320).clipShape(RoundedRectangle(cornerRadius: 24))
                .accessibilityLabel("Map of four sample restaurant locations in Dubai")

                if let restaurant = selectedRestaurant {
                    VStack(alignment: .leading, spacing: 12) {
                        Label(restaurant.name, systemImage: "mappin.circle.fill").font(.headline)
                        Text(restaurant.address).font(.subheadline).foregroundStyle(.secondary)
                        NavigationLink {
                            RestaurantDetailView(restaurant: restaurant)
                        } label: {
                            Text("View restaurant menu")
                        }.buttonStyle(PrimaryButtonStyle())
                    }
                    .padding(18).background(Color(uiColor: .secondarySystemGroupedBackground),
                                             in: RoundedRectangle(cornerRadius: 20))
                }

                HStack {
                    Text("Explore the neighbourhood").font(.headline)
                    Spacer()
                    Button("Show all") { selectedID = nil; showAll() }.font(.caption.bold())
                }
                ForEach(SampleData.restaurants) { restaurant in
                    Button { select(restaurant) } label: {
                        HStack(spacing: 14) {
                            Text(restaurant.emoji).font(.largeTitle).frame(width: 55, height: 55)
                                .background(Theme.peach, in: RoundedRectangle(cornerRadius: 14))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(restaurant.name).font(.headline).foregroundStyle(.primary)
                                Text(restaurant.address).font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer(minLength: 0)
                            Image(systemName: selectedID == restaurant.id ? "checkmark.circle.fill" : "location.circle")
                        }.padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 18))
                    }.buttonStyle(.plain).accessibilityLabel("Show \(restaurant.name) on map")
                }
                DemoNotice(text: "Fictional restaurants at illustrative Dubai locations. Map tiles need internet. No device location permission is required.")
            }.padding(20)
        }
        .background(Theme.background)
        .navigationTitle("Locations").navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let restaurant = SampleData.restaurants.first(where: { $0.id == initialRestaurantID }) {
                select(restaurant)
            }
        }
    }

    private func select(_ restaurant: Restaurant) {
        selectedID = restaurant.id
        withAnimation {
            camera = .region(MKCoordinateRegion(center: restaurant.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)))
        }
    }

    private func showAll() {
        withAnimation {
            camera = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.198, longitude: 55.274),
                                                span: MKCoordinateSpan(latitudeDelta: 0.055, longitudeDelta: 0.055)))
        }
    }
}
