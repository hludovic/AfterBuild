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

    @Published var locations: [SpotLocation] = []

    @Published var alertItem: AlertItem?

    func getLocations() {
        Task {
            do {
                let locationsResult = try await CloudKitManager.shared.getLocations()
                locations = locationsResult
            } catch {
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }

}
