//
//  LocationDetailViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 11/09/2023.
//

import SwiftUI
import MapKit

final class LocationDetailViewModel: ObservableObject {
    @Published var alertItem: AlertItem? {
        didSet { isShowingAlert = true }
    }
    @Published var isShowingAlert: Bool = false
    @Published var isShowingProfileModal: Bool = false

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var location: SpotLocation

    init(location: SpotLocation) { self.location = location }

    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    func callLocation() {
        guard let url = URL(string: "tem://\(location.phoneNumber)") else {
            return alertItem = AlertContext.wrongPhoneNumber
        }
        UIApplication.shared.open(url)
    }
}
