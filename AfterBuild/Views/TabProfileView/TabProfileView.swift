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

    @State private var viewModel = TabProfileViewModel()
    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
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
                                .modifier(ProfileNameStyle())
                            TextField("Last Name", text: $viewModel.lastName)
                                .focused($focusedField, equals: .lastName)
                                .submitLabel(.next)
                                .textContentType(.familyName)
                                .modifier(ProfileNameStyle())
                            TextField("Company Name", text: $viewModel.companyName)
                                .focused($focusedField, equals: .companyName)
                                .textContentType(.organizationName)
                                .submitLabel(.next)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 7) {
                    HStack{
                        CharactersRemainView(currentCount: viewModel.bio.count)

                        Spacer()
                        
                        if viewModel.isCheckedIn {
                            Button {
                                Task {
                                    await viewModel.checkOutStatus()
                                    hapticFeedback()
                                }
                            } label: {
                                Label("Ceck Out", systemImage: "mappin.and.ellipse")
                            }
                            .foregroundStyle(Color.white)
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(Color.afterBuildRed)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }

                    TextField("Enter your bio", text: $viewModel.bio, axis: .vertical)
                        .focused($focusedField, equals: .bio)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(4...6)
                }
                Spacer()
                Button {
                    Task {
                        viewModel.profileContext == .create
                        ? await viewModel.createProfile()
                        : await viewModel.updateProfile()
                    }
                } label: {
                    ButtonText(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .padding(.bottom)
            }
            .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
            if viewModel.isLoading { LoadingView() }
        }
        .task {
            await viewModel.getProfile()
            await viewModel.getCheckInStatus()
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

#Preview {
    NavigationStack {
        TabProfileView()
    }
}
