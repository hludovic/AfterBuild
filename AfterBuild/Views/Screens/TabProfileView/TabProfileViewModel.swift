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

    func getProfile() async {
        guard let userRecord = CloudKitManager.shared.userRecord else {
            return print("ERROR")
        }
        guard let profileReferance = userRecord["userProfile"] as? CKRecord.Reference else {
            return print("ERROR")
        }
        var profileRecord: CKRecord? = nil
        do {
            profileRecord = try await CloudKitManager.shared.fetchRecord(with: profileReferance.recordID)
        } catch {
            print("ERROR")
        }
        guard let profileRecord else { return }
        let profile = UserProfile(record: profileRecord)
        await MainActor.run {
            firstName = profile.firstName
            lastName = profile.lastName
            companyName = profile.compagnyName
            bio = profile.bio
            avatar = profile.avatar.convertToUiimage(for: .square)
        }
    }

    func createProfile() async {
        guard isValidProfile() else { return alertItem = AlertContext.invalidProfile }
        guard let userRecord = CloudKitManager.shared.userRecord else {
            return print("ERROR")
        }
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompagnyName] = companyName
        profileRecord[UserProfile.kBio] = bio
        profileRecord[UserProfile.kAvatar] = avatar.convertToCKAsset()
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        do {
            _ = try await CloudKitManager.shared.save(records: [userRecord, profileRecord])
        } catch {
            print("ERROR")
        }
    }

    private func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              bio.count <= 100,
              avatar != PlaceholderImage.avatar else { return false }
        return true
    }
}
