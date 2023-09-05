//
//  TabProfileView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabProfileView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var companyName: String = ""
    @State private var bio: String = ""
    @State private var avatar: UIImage = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker: Bool = false

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
                            .profileNameStyle()
                        TextField("Last Name", text: $lastName)
                            .profileNameStyle()
                        TextField("Company Name", text: $companyName)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 7) {
                CharactersRemainView(currentCount: bio.count)

                TextField("Enter your bio", text: $bio, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...6)
            }
            Spacer()
            Button(action: {
                print("Button tapped!")
            }) {
                ButtonText(title: "Create Profile")
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
        .padding(.horizontal)
        .navigationTitle("Profile")
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct TabProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabProfileView()

        }
    }
}
