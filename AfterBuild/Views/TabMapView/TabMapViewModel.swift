//
//  TabMapViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import _MapKit_SwiftUI

final class TabMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isShowingOnboardView: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertItem: AlertItem? { didSet { isShowingAlert = true } }
    @Published var position: MapCameraPosition = .automatic
    var deviceLocationManager: CLLocationManager = CLLocationManager()
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.hasSeenOnboardView)
    }

    override init() {
        super.init()
        deviceLocationManager.delegate = self
    }

    func requestAllowOnceLocationPermission() {
        deviceLocationManager.requestLocation()
    }

    func checkIfHasSeenOnboard() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.setValue(true, forKey: StorageKey.hasSeenOnboardView)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        position = .userLocation(followsHeading: true, fallback: .automatic)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
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
