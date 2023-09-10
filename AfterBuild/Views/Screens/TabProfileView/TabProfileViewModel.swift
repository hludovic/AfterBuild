//
//  TabProfileViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 06/09/2023.
//

import CloudKit
import SwiftUI


final class TabProfileViewModel: ObservableObject {
    enum Context { case update, create }
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var companyName: String = ""
    @Published var bio: String = ""
    @Published var avatar: UIImage = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem? { didSet { isShowingAlert = true } }

    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }
    var profileContext: Context = .create

    func getProfile() async {
        guard let userRecord = CloudKitManager.shared.userRecord else {
            return await MainActor.run { alertItem = AlertContext.noUserRecord }
        }
        guard let profileReferance = userRecord["userProfile"] as? CKRecord.Reference else { return }
        await showLoadingView()
        var profileRecord: CKRecord? = nil
        do {
            profileRecord = try await CloudKitManager.shared.fetchRecord(with: profileReferance.recordID)
            await hideLoadingView()
        } catch {
            await hideLoadingView()
            return await MainActor.run { alertItem = AlertContext.getProfileFailure }
        }
        guard let profileRecord else { return }
        existingProfileRecord = profileRecord
        let profile = UserProfile(record: profileRecord)
        await MainActor.run {
            firstName = profile.firstName
            lastName = profile.lastName
            companyName = profile.compagnyName
            bio = profile.bio
            avatar = profile.avatar.convertToUiimage(for: .square)
        }
    }

    func updateProfile() async {
        guard isValidProfile() else { return alertItem = AlertContext.invalidProfile }
        guard let profileRecord = existingProfileRecord else { return alertItem = AlertContext.getProfileFailure }
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompagnyName] = companyName
        profileRecord[UserProfile.kBio] = bio
        profileRecord[UserProfile.kAvatar] = avatar.convertToCKAsset()
        await showLoadingView()
        do {
            existingProfileRecord = try await CloudKitManager.shared.save(record: profileRecord)
            await hideLoadingView()
            await MainActor.run { alertItem = AlertContext.updateProfileSuccess }
        } catch {
            await hideLoadingView()
            await MainActor.run { alertItem = AlertContext.updateProfileFailure }
        }

    }

    func createProfile() async {
        guard isValidProfile() else { return alertItem = AlertContext.invalidProfile }
        guard let userRecord = CloudKitManager.shared.userRecord else {
            return await MainActor.run { alertItem = AlertContext.noUserRecord }
        }
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompagnyName] = companyName
        profileRecord[UserProfile.kBio] = bio
        profileRecord[UserProfile.kAvatar] = avatar.convertToCKAsset()
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        await showLoadingView()
        do {
            let records = try await CloudKitManager.shared.save(records: [userRecord, profileRecord])
            for record in records where record.recordType == RecordType.profile {
                existingProfileRecord = record
            }
            await hideLoadingView()
            await MainActor.run { alertItem = AlertContext.createProfileSuccess }
        } catch {
            await hideLoadingView()
            await MainActor.run { alertItem = AlertContext.createProfileFailure }
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
    @MainActor private func showLoadingView() { isLoading = true}
    @MainActor private func hideLoadingView() { isLoading = false}
}
