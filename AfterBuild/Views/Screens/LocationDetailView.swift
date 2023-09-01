//
//  LocationDetailView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 19/08/2023.
//

import SwiftUI

struct LocationDetailView: View {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]

    var location: SpotLocation
    
    var body: some View {
        VStack(spacing: 17) {
            BannerImageView(image: location.createBannerImage())
            HStack {
                AddressView(address: location.address)
                Spacer()
            }
            .padding(.horizontal)

            DescriptionView(description: location.description)
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(uiColor: .secondarySystemBackground))
                HStack(spacing: 20) {
                    Button {
                        print("action")
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    Link(destination: URL(string: location.websiteURL)!) {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                    }
                    Button {
                        print("action")
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
                LazyVGrid(columns: columns) {
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
        .navigationTitle(location.name)
        Spacer()
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationDetailView(location: SpotLocation(record: MockData.location))
        }
    }
}
