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
    @Published var checkedInProfiles: [UserProfile] = []
    @Published var isCheckedIn: Bool = false
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
        let profileRecord: CKRecord? = try? await CloudKitManager.shared.fetchRecord(with: userProfileRecordID)
        guard let profileRecord else { return print("ERROR") }

        switch checkInStatus {
        case .checkedIn:
            profileRecord[UserProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
        case .checkedOut:
            profileRecord[UserProfile.kIsCheckedIn] = nil
        }

        let savedProfile = try? await CloudKitManager.shared.save(record: profileRecord)
        guard let savedProfile else { return print("ERROR") }
        let userProfile = UserProfile(record: savedProfile)

        switch checkInStatus {
        case .checkedIn:
            await MainActor.run {
                self.checkedInProfiles.append(userProfile)
                print("CHeckedID")
            }
        case .checkedOut:
            await MainActor.run {
                checkedInProfiles.removeAll { $0.id == userProfile.id }
                print("CHeckedOut")
            }
        }
        await MainActor.run {
            isCheckedIn = checkInStatus == .checkedIn
        }
    }
    
    func getCheckedInProfiles() async {
        do {
            let profiles = try await CloudKitManager.shared.getCheckInProfiles(for: location.id)
            await MainActor.run { checkedInProfiles = profiles }
        } catch {
            print(error.localizedDescription)
        }
    }
}
