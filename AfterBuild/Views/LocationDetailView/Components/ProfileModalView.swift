//
//  ProfileModalView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 12/09/2023.
//

import SwiftUI

struct ProfileModalView: View {
    @Binding var isShowing: Bool
    var profile: UserProfile

    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text("\(profile.firstName) \(profile.lastName)")
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text(profile.compagnyName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)

                Text(profile.bio)
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation { isShowing = false }
                } label: {
                    DismissButton()
                }

            }

            Image(uiImage: profile.getAvatar())
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                .offset(x: 0, y: -120)
        }
    }
}

#Preview {
    ProfileModalView(isShowing: .constant(true), profile: UserProfile(record: MockData.profile))
}
