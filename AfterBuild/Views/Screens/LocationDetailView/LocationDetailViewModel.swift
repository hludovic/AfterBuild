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
    @Published var isLoading: Bool = false

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

    func getCheckInStatus() async {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else{ return }
        let userProfileRecord = try? await CloudKitManager.shared.fetchRecord(with: profileRecordID)
        guard let userProfileRecord else { 
            return alertItem = AlertContext.unableToGetCheckInStatus
        }
        guard let reference = userProfileRecord[UserProfile.kIsCheckedIn] as? CKRecord.Reference else {
            return await MainActor.run { isCheckedIn = false }
        }
        await MainActor.run { isCheckedIn = reference.recordID == location.id }
    }

    func updateCheckInStatus(to checkInStatus: CheckInStatus) async {
        guard let userProfileRecordID = CloudKitManager.shared.profileRecordID else { 
            return alertItem = AlertContext.getProfileFailure
        }
        let profileRecord: CKRecord? = try? await CloudKitManager.shared.fetchRecord(with: userProfileRecordID)
        guard let profileRecord else { return alertItem = AlertContext.unableToCheckInOut }

        switch checkInStatus {
        case .checkedIn:
            profileRecord[UserProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
        case .checkedOut:
            profileRecord[UserProfile.kIsCheckedIn] = nil
        }

        let savedProfile = try? await CloudKitManager.shared.save(record: profileRecord)
        guard let savedProfile else { return alertItem = AlertContext.unableToCheckInOut }
        let userProfile = UserProfile(record: savedProfile)

        switch checkInStatus {
        case .checkedIn:
            await MainActor.run { self.checkedInProfiles.append(userProfile) }
        case .checkedOut:
            await MainActor.run { checkedInProfiles.removeAll { $0.id == userProfile.id } }
        }
        await MainActor.run {
            isCheckedIn = checkInStatus == .checkedIn
        }
    }
    
    func getCheckedInProfiles() async {
        await showLoadingView()
        do {
            let profiles = try await CloudKitManager.shared.getCheckInProfiles(for: location.id)
            await MainActor.run { checkedInProfiles = profiles }
            await hideLoadingView()
        } catch {
            await hideLoadingView()
            alertItem = AlertContext.unableToGetCheckedInProfiles
        }
    }

    @MainActor private func showLoadingView() { isLoading = true}
    @MainActor private func hideLoadingView() { isLoading = false}

}
