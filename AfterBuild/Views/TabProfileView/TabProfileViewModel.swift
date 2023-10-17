//
//  TabProfileViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 06/09/2023.
//

import CloudKit
import SwiftUI
import Observation

@Observable final class TabProfileViewModel {
    enum Context { case update, create }
    var firstName: String = ""
    var lastName: String = ""
    var companyName: String = ""
    var bio: String = ""
    var avatar: UIImage = PlaceholderImage.avatar
    var isShowingPhotoPicker: Bool = false
    var isShowingAlert: Bool = false
    var isLoading: Bool = false
    var alertItem: AlertItem? { didSet { isShowingAlert = true } }
    var isCheckedIn: Bool = false
    var profileContext: Context = .create
    private var existingProfileRecord: CKRecord? { didSet { profileContext = .update } }

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
            avatar = profile.getAvatar()
        }
    }

    func getCheckInStatus() async {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else{ return }
        let userProfileRecord = try? await CloudKitManager.shared.fetchRecord(with: profileRecordID)
        guard let userProfileRecord else { return }
        guard userProfileRecord[UserProfile.kIsCheckedIn] is CKRecord.Reference else {
            return await MainActor.run { isCheckedIn = false }
        }
        await MainActor.run { isCheckedIn = true }
    }

    func checkOutStatus() async {
        guard let userProfileID = CloudKitManager.shared.profileRecordID else { 
            return alertItem = AlertContext.getProfileFailure
        }
        let userRecord = try? await CloudKitManager.shared.fetchRecord(with: userProfileID)
        guard let userRecord else {
            return await MainActor.run { alertItem = AlertContext.unableToCheckInOut }
        }
        userRecord[UserProfile.kIsCheckedIn] = nil
        let savedProfile = try? await CloudKitManager.shared.save(record: userRecord)
        guard savedProfile != nil else {
            return await MainActor.run { alertItem = AlertContext.unableToCheckInOut }
        }
        await MainActor.run { isCheckedIn = false }
    }

    func updateProfile() async {
        guard isValidProfile() else { return await MainActor.run {  alertItem = AlertContext.invalidProfile } }
        guard let profileRecord = existingProfileRecord else {
            return await MainActor.run { alertItem = AlertContext.getProfileFailure } }
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompanyName] = companyName
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
        guard isValidProfile() else { return await MainActor.run {  alertItem = AlertContext.invalidProfile } }
        guard let userRecord = CloudKitManager.shared.userRecord else {
            return await MainActor.run { alertItem = AlertContext.noUserRecord }
        }
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[UserProfile.kFirstName] = firstName
        profileRecord[UserProfile.kLastName] = lastName
        profileRecord[UserProfile.kCompanyName] = companyName
        profileRecord[UserProfile.kBio] = bio
        profileRecord[UserProfile.kAvatar] = avatar.convertToCKAsset()
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        await showLoadingView()
        do {
            let records = try await CloudKitManager.shared.save(records: [userRecord, profileRecord])
            for record in records where record.recordType == RecordType.profile {
                existingProfileRecord = record
                CloudKitManager.shared.profileRecordID = record.recordID
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
