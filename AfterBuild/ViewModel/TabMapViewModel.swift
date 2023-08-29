//
//  TabMapViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import MapKit

final class TabMapViewModel: ObservableObject {
    @Published var coordonateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 37.331516, longitude: -121.891054),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @Published var alertItem: AlertItem?

    func getLocations(for locationManager: LocationManager) {
        Task {
            do {
                let locationsResult = try await CloudKitManager.shared.getLocations()
                await MainActor.run { locationManager.locations = locationsResult }
            } catch {
                await MainActor.run{ alertItem = AlertContext.unableToGetLocations }
            }
        }
    }

}
