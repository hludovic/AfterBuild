//
//  TabProfileViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 06/09/2023.
//

import CloudKit
import SwiftUI

final class TabProfileViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var companyName: String = ""
    @Published var bio: String = ""
    @Published var avatar: UIImage = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertItem: AlertItem? { didSet { isShowingAlert = true } }


    func getProfile() async throws {
        let container = CKContainer.default()
        let userID = try await container.userRecordID()
        let userRecord = try await container.publicCloudDatabase.record(for: userID)
        let profileReferance = userRecord["userProfile"] as! CKRecord.Reference
        let profileRecord = try await container.publicCloudDatabase.record(for: profileReferance.recordID)
        let profile = UserProfile(record: profileRecord)
        await MainActor.run {
            firstName = profile.firstName
            lastName = profile.lastName
            companyName = profile.compagnyName
            bio = profile.bio
            avatar = profile.avatar.convertToUiimage(for: .square)
        }
    }

    func createProfile() async throws {
        let container = CKContainer.default()
        guard isValidProfile() else { return alertItem = AlertContext.invalidProfile }
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompagnyName] = companyName
        profileRecord[UserProfile.kBio] = bio
        profileRecord[UserProfile.kAvatar] = avatar.convertToCKAsset()
        let recordID = try await container.userRecordID()
        let userRecord = try await container.publicCloudDatabase.record(for: recordID)
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        let (saveResults, _) = try await container.publicCloudDatabase.modifyRecords(saving: [userRecord, profileRecord], deleting: [])
        let result = saveResults.compactMap { (recordID, result) in try? result.get() }
        print(result)
    }

    private func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              bio.count < 100,
              avatar != PlaceholderImage.avatar else { return false }
        return true
    }
}
