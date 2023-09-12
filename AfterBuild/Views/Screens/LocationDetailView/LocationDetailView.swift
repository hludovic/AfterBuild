//
//  LocationDetailView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 19/08/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
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
                    Button {
                        print("action")
                    } label: {
                        LocationActionButton(color: .red, imageName: "person.fill.checkmark")
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Who's There")
                .fontWeight(.bold)
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    FirstNameAvatarView(firstName: "Pierre")
                    FirstNameAvatarView(firstName: "Paul")
                    FirstNameAvatarView(firstName: "Jack")
                    FirstNameAvatarView(firstName: "Marc")
                    FirstNameAvatarView(firstName: "Martine")
                    FirstNameAvatarView(firstName: "Antoine")
                    FirstNameAvatarView(firstName: "Lise")
                }
            }
        }
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
        .navigationTitle(viewModel.location.name)
        Spacer()
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let location = SpotLocation(record: MockData.location)
        NavigationStack {
            LocationDetailView(viewModel: LocationDetailViewModel(location: location))
        }
    }
}
