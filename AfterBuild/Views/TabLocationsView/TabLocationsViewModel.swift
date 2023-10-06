//
//  TabLocationsViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import CloudKit

final class TabLocationsViewModel: ObservableObject {
    @Published var checkedInProfiles: [CKRecord.ID: [UserProfile]] = [:]

    func getCheckedInProfiles(in locations: [SpotLocation]) async {
        let users: [UserProfile]? = try? await CloudKitManager.shared.getUserProfilesChecked(in: locations)
        guard let users else { return print("Unable to get Userprofiles Checked-In") }
        await MainActor.run { checkedInProfiles = sortByLocations(users: users) }
    }

    private func sortByLocations(users: [UserProfile]) -> [CKRecord.ID : [UserProfile]] {
        var result: [CKRecord.ID : [UserProfile]] = [:]
        for user in users {
            if let locationReference = user.isCheckedIn {
                result[locationReference.recordID, default: []].append(user)
            }
        }
        return result
    }

}
