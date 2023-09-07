//
//  TabMapViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import MapKit

final class TabMapViewModel: NSObject, ObservableObject {
    @Published var isShowingOnboardView: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertItem: AlertItem? {
        didSet {
            isShowingAlert = true
        }
    }
    @Published var coordonateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 37.331516, longitude: -121.891054),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    var deviceLocationManager: CLLocationManager?
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.hasSeenOnboardView)
    }

    func runStartumCheck() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.setValue(true, forKey: StorageKey.hasSeenOnboardView)
        } else {
            startLocationService()
        }
    }

    func startLocationService() {
//        if CLLocationManager.locationServicesEnabled() {
            self.deviceLocationManager = CLLocationManager()
            self.deviceLocationManager!.delegate = self
//        } else {
//            self.alertItem = AlertContext.locationDisabled
//        }
    }

    private func checkLocationAuthorisation() {
        guard let deviceLocationManager else { return }
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
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
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // This function is called when CLLocationManager is instancied
        checkLocationAuthorisation()
    }



}
