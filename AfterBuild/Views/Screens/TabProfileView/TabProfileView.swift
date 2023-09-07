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

    @StateObject private var viewModel = TabProfileViewModel()
    @FocusState var focusedField: Field?


    var body: some View {
        VStack {
            ZStack {
                RoudedBackground()

                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84, image: viewModel.avatar)
                        EditImage()
                    }
                    .onTapGesture { viewModel.isShowingPhotoPicker = true}
                    .padding(.leading, 12)
                    VStack(spacing: 1) {
                        TextField("First Name", text: $viewModel.firstName)
                            .focused($focusedField, equals: .firstName)
                            .textContentType(.givenName)
                            .submitLabel(.next)
                            .profileNameStyle()
                        TextField("Last Name", text: $viewModel.lastName)
                            .focused($focusedField, equals: .lastName)
                            .submitLabel(.next)
                            .textContentType(.familyName)
                            .profileNameStyle()
                        TextField("Company Name", text: $viewModel.companyName)
                            .focused($focusedField, equals: .companyName)
                            .textContentType(.organizationName)
                            .submitLabel(.next)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 7) {
                CharactersRemainView(currentCount: viewModel.bio.count)

                TextField("Enter your bio", text: $viewModel.bio, axis: .vertical)
                    .focused($focusedField, equals: .bio)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...6)
            }
            Spacer()
            Button(action: {
                Task {
                    do {
//                        try await createProfile()
                        try await viewModel.getProfile()

                    } catch {
                        print(error.localizedDescription)
                    }

                }
            }) {
                ButtonText(title: "Create Profile")
            }
            .padding(.bottom)
            .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)

        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
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
}

struct TabProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabProfileView()

        }
    }
}
