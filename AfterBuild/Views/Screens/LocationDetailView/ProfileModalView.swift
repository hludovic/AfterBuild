//
//  ProfileModalView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 12/09/2023.
//

import SwiftUI

struct ProfileModalView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text("Ludovic HENRY")
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text("Compagny Name")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)

                Text("This is my samble bio.This is my samble bio. This is my samble bio. This is my samble bio. This is my samble bio")
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
            .overlay(alignment: .topTrailing) {
                Button {
                    print("Dismiss")
                } label: {
                    DismissButton()
                }

            }

            Image(uiImage: PlaceholderImage.avatar)
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
    ProfileModalView()
}
