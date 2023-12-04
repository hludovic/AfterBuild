//
//  TabMapViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import _MapKit_SwiftUI
import CloudKit
import Observation

@Observable final class TabMapViewModel: NSObject {
    var isShowingAlert: Bool = false
    var isShowingDetailView: Bool = false
    var alertItem: AlertItem? { didSet { isShowingAlert = true } }
    var position: MapCameraPosition = .automatic
    var checkedInCount: [CKRecord.ID: Int] = [:]
    var displayLocationPermissionButton: Bool = true
    private var deviceLocationManager: CLLocationManager = CLLocationManager()

    override init() {
        super.init()
        deviceLocationManager.delegate = self
    }

    func requestAllowOnceLocationPermission() {
        deviceLocationManager.requestWhenInUseAuthorization()
    }
    
    func startupTasks(with locationManager: LocationManager) {
        checkLocationPermissions()
        Task {
            if locationManager.locations.isEmpty {
                await getLocations(for: locationManager)
            }
            await getCheckdedInCount(with: locationManager)
        }
    }

    func getLocations(for locationManager: LocationManager) async {
        do {
            let locationsResult = try await CloudKitManager.shared.getLocations()
            await MainActor.run { locationManager.locations = locationsResult }
        } catch {
            await MainActor.run{ alertItem = AlertContext.unableToGetLocations }
        }
    }

    func getCheckdedInCount(with locationManader: LocationManager) async {
        let result = try? await CloudKitManager.shared.getCheckdInProfilesCount(in: locationManader.locations)
        guard let result else { return print("Unable tou get Checked-In profiles Count") }
        await MainActor.run { checkedInCount = result }
    }

    func checkLocationPermissions() {
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            displayLocationPermissionButton = true
        case .restricted:
            displayLocationPermissionButton = true
        case .denied:
            displayLocationPermissionButton = true
        case .authorizedAlways:
            displayLocationPermissionButton = false
        case .authorizedWhenInUse:
            displayLocationPermissionButton = false
        case .authorized:
            displayLocationPermissionButton = false
        @unknown default:
            displayLocationPermissionButton = false
        }
    }
}

extension TabMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        position = .userLocation(followsHeading: true, fallback: .automatic)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermissions()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
