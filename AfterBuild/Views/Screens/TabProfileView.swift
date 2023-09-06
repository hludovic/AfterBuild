//
//  TabProfileView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

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
    @State private var alertItem: AlertItem? {
        didSet { isShowingAlert = true }
    }
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
                            .profileNameStyle()
                        TextField("Last Name", text: $lastName)
                            .focused($focusedField, equals: .lastName)
                            .profileNameStyle()
                        TextField("Company Name", text: $companyName)
                            .focused($focusedField, equals: .companyName)
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
                createProfile()
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
    }

    func createProfile() {
        guard isValidProfile() else { return alertItem = AlertContext.invalidProfile }
        // Upload the profil
    }


    private func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              bio.isEmpty,
              bio.count > 100,
              avatar != PlaceholderImage.avatar else {
            return false }
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
