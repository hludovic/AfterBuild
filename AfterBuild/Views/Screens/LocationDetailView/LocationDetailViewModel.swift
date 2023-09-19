//
//  LocationDetailViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 11/09/2023.
//

import SwiftUI
import MapKit
import CloudKit

final class LocationDetailViewModel: ObservableObject {
    enum CheckInStatus { case checkedIn, checkedOut }
    @Published var alertItem: AlertItem? { didSet { isShowingAlert = true } }
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
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            return alertItem = AlertContext.wrongPhoneNumber
        }
        UIApplication.shared.open(url)
    }

    func updateCheckInStatus(to checkInStatus: CheckInStatus) async {
        guard let userProfileRecordID = CloudKitManager.shared.profileRecordID else { 
            return // NO PROFILE + HIDE BUTTON
        }

        var profileRecord: CKRecord? = nil
        do {
            profileRecord = try await CloudKitManager.shared.fetchRecord(with: userProfileRecordID)
            switch checkInStatus {
            case .checkedIn:
                profileRecord?[UserProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
            case .checkedOut:
                profileRecord?[UserProfile.kIsCheckedIn] = nil
            }
        } catch {
            return print("ERROR + NO PROFILE RECORD")
        }
        
        guard let profileRecord else { return }

        do {
            _ = try await CloudKitManager.shared.save(record: profileRecord)
        } catch {
            return print("ERROR + UNABLE TO SAVE")
        }
    }
}
