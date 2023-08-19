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
        NavigationStack {
            VStack(spacing: 17) {
                Image("default-banner-asset")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                HStack {
                    Label("1 S Market St Ste 40", systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal)
                Text("Its is the description of the spot Its is the description of the spot Its is the description of the spot Its is the description of the spot")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)

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

                LazyVGrid(columns: columns) {
                    FirstNameAvatarView(firstName: "Pierre")
                    FirstNameAvatarView(firstName: "Paul")
                    FirstNameAvatarView(firstName: "Jack")
                    FirstNameAvatarView(firstName: "Marc")
                    FirstNameAvatarView(firstName: "Martine")
                    FirstNameAvatarView(firstName: "Antoine")
                    FirstNameAvatarView(firstName: "Lise")
                }

                Spacer()

            }
            .navigationTitle("Location Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
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
