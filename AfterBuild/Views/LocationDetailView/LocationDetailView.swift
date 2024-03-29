//
//  LocationDetailView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 19/08/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @State var viewModel: LocationDetailViewModel
    @State var isAnimate: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 17) {
                BannerImageView(image: viewModel.location.createBannerImage())
                HStack {
                    AddressView(address: viewModel.location.address)
                    Spacer()
                }
                .padding(.horizontal)

                DescriptionView(description: viewModel.location.description)

                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(uiColor: .secondarySystemBackground))
                    HStack(spacing: 20) {
                        Button {
                            viewModel.getDirectionsToLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        Link(destination: URL(string: viewModel.location.websiteURL)!) {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        }
                        Button {
                            viewModel.callLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                        }
                        if CloudKitManager.shared.profileRecordID != nil {
                            Button {
                                Task { await viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn) }
                            } label: {
                                LocationActionButton(
                                    color: viewModel.isCheckedIn ? .brandSecondary : .brandPrimary,
                                    imageName: viewModel.isCheckedIn ? "person.fill.xmark" : "person.fill.checkmark"
                                )
                            }
                            .animation(.easeIn, value: viewModel.isCheckedIn)
                        }
                    }
                }
                .padding(.horizontal)

                Text("Who's There ?")
                    .fontWeight(.bold)
                    .font(.title2)

                ZStack {
                    if viewModel.checkedInProfiles.isEmpty {
                        Text("Nobody's here ☹️")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.secondary)
                            .padding(.top, 30)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: viewModel.columns) {
                                ForEach(viewModel.checkedInProfiles) { profile in
                                    FirstNameAvatarView(profile: profile)
                                        .onTapGesture {
                                            withAnimation(.easeIn(duration: 0.2)) { viewModel.profileModal = profile }
                                        }
                                }
                            }
                        }
                    }
                    if viewModel.isLoading { LoadingView() }
                }
                Spacer()
            }

            if viewModel.isShowingProfileModal {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.9)
                    .zIndex(1)
                    .transition(.opacity)
                ProfileModalView(
                    isShowing: $viewModel.isShowingProfileModal,
                    profile: viewModel.profileModal!
                )
                .transition(.opacity.combined(with: .slide))
                .zIndex(2)
            }
        }
        .task {
            await viewModel.getCheckInStatus()
            await viewModel.getCheckedInProfiles()
        }
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
        .navigationTitle(viewModel.location.name)
    }
}


#Preview("Default") {
    LocationDetailView(viewModel: LocationDetailViewModel(location: SpotLocation(record: MockData.chipotle)))
}

#Preview("Extra Large") {
    LocationDetailView(viewModel: LocationDetailViewModel(location: SpotLocation(record: MockData.chipotle)))
        .environment(\.dynamicTypeSize, .xxLarge)
        .preferredColorScheme(.dark)
}

#Preview {
    NavigationStack {
        LocationDetailView(viewModel: LocationDetailViewModel(location: SpotLocation(record: MockData.chipotle)))
            .environment(\.dynamicTypeSize, .accessibility5)
    }
}

