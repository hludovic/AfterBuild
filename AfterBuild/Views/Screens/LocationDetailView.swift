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
    
    var body: some View {
        VStack(spacing: 17) {
            BannerImageView(imageName: "default-banner-asset")
            HStack {
                AddressView(address: "1 S Market St Ste 40")
                Spacer()
            }
            .padding(.horizontal)

            DescriptionView(description: "Its is the description of the spot Its is the description of the spot Its is the description of the spot Its is the description of the spot")
            
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
                    Button {
                        print("action")
                    } label: {
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
        .navigationTitle("Location Name")
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationDetailView()
        }
    }
}

struct LocationActionButton: View {
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(height: 60)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 22)
                .foregroundColor(.white)
        }
    }
}

struct FirstNameAvatarView: View {
    var firstName: String
    
    var body: some View {
        VStack {
            AvatarView(size: 65)
            Text(firstName)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    var address: String

    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    var description: String

    var body: some View {
        Text(description)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
