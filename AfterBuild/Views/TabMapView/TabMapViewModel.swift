//
//  TabMapViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import _MapKit_SwiftUI

final class TabMapViewModel: NSObject, ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var isShowingDetailView: Bool = false
    @Published var alertItem: AlertItem? { didSet { isShowingAlert = true } }
    @Published var position: MapCameraPosition = .automatic
    private var deviceLocationManager: CLLocationManager = CLLocationManager()

    override init() {
        super.init()
        deviceLocationManager.delegate = self
    }

    func requestAllowOnceLocationPermission() {
        deviceLocationManager.requestLocation()
    }

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

extension TabMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        position = .userLocation(followsHeading: true, fallback: .automatic)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
