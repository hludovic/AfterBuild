//
//  TabLocationsViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import Foundation
import CloudKit

final class TabLocationsViewModel: ObservableObject {

    func getUsersChecked() async {
        let locations: [SpotLocation]? = try? await CloudKitManager.shared.getLocations()
        guard let locations else { return }
        let users: [UserProfile]? = try? await CloudKitManager.shared.getUserProfilesChecked(in: locations)
        guard let users else { return }
        let sorted = sortByLocations(users: users)
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
