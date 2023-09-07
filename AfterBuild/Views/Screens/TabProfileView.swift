//
//  TabProfileView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI
import CloudKit

struct TabProfileView: View {
    enum Field {
        case firstName
        case lastName
        case companyName
        case bio
    }

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var companyName: String = ""
    @State private var bio: String = ""
    @State private var avatar: UIImage = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker: Bool = false
    @State private var isShowingAlert: Bool = false
    @State private var alertItem: AlertItem? { didSet { isShowingAlert = true } }
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            ZStack {
                RoudedBackground()

                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84, image: avatar)
                        EditImage()
                    }
                    .onTapGesture { isShowingPhotoPicker = true}
                    .padding(.leading, 12)
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .focused($focusedField, equals: .firstName)
                            .textContentType(.givenName)
                            .submitLabel(.next)
                            .profileNameStyle()
                        TextField("Last Name", text: $lastName)
                            .focused($focusedField, equals: .lastName)
                            .submitLabel(.next)
                            .textContentType(.familyName)
                            .submitLabel(.next)
                            .profileNameStyle()
                        TextField("Company Name", text: $companyName)
                            .focused($focusedField, equals: .companyName)
                            .textContentType(.organizationName)
                            .submitLabel(.next)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 7) {
                CharactersRemainView(currentCount: bio.count)

                TextField("Enter your bio", text: $bio, axis: .vertical)
                    .focused($focusedField, equals: .bio)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...6)
            }
            Spacer()
            Button(action: {
                Task {
                    do {
//                        try await createProfile()
                        try await getProfile()

                    } catch {
                        print(error.localizedDescription)
                    }

                }
            }) {
                ButtonText(title: "Create Profile")
            }
            .padding(.bottom)
            .alertMessage(item: alertItem, isPresented: $isShowingAlert)

        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
        .padding(.horizontal)
        .navigationTitle("Profile")
        .toolbarBackground(.visible, for: .tabBar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    focusedField = nil
                } label: {
                    Label("dismiss keyboard", systemImage: "keyboard.chevron.compact.down")
                }
            }
        }
        .onSubmit {
            switch focusedField {
            case .firstName:
                focusedField = .lastName
            case .lastName:
                focusedField = .companyName
            case .companyName:
                focusedField = .bio
            default:
                focusedField = .firstName
            }
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

    func getProfile() async throws {
        let container = CKContainer.default()

        let userID = try await container.userRecordID()
        let userRecord = try await container.publicCloudDatabase.record(for: userID)
        let profileReferance = userRecord["userProfile"] as! CKRecord.Reference

        let profileRecord = try await container.publicCloudDatabase.record(for: profileReferance.recordID)

        let profile = UserProfile(record: profileRecord)
        firstName = profile.firstName
        lastName = profile.lastName
        companyName = profile.compagnyName
        bio = profile.bio
        avatar = profile.avatar.convertToUiimage(for: .square)

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

struct TabProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabProfileView()

        }
    }
}
