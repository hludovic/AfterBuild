//
//  TabProfileView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabProfileView: View {
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 130)
                    .foregroundColor(Color(uiColor: .secondarySystemBackground))
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 14)
                            .foregroundColor(.white)
                            .offset(x: 0, y: 32)
                    }
                    .padding(.leading, 12)
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        TextField("Company Name", text: $companyName)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 7) {
                Text("Bio: ")
                    .font(.callout)
                    .foregroundColor(.secondary)
                +
                Text("\(100 - bio.count)")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(bio.count <= 100 ? .brandPrimary : Color(uiColor: .systemPink))
                +
                Text(" characters remain")
                    .font(.callout)
                    .foregroundColor(.secondary)

                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    }
            }

            Spacer()

            Button(action: {
                print("Button tapped!")
            }) {
                Text("Create Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .foregroundColor(.white)
                    .background(Color.brandPrimary)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)
        .navigationTitle("Profile")
    }
}

struct TabProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabProfileView()
        }
    }
}
