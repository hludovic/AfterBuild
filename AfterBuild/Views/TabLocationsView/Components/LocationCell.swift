//
//  LocationCell.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct LocationCell: View {
    var location: SpotLocation
    var profiles: [UserProfile]

    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 7)

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    if profiles.isEmpty {
                        Text("Nobody's Checked In")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                            .padding(.top, 2)
                    } else {
                        HStack {
                            ForEach(profiles.indices ,id: \.self) { indice in
                                if indice <= 3 {
                                    AvatarView(size: 35, image: profiles[indice].getAvatar())
                                } else  if indice == 4 {
                                    AdditionalProfilesView(number: profiles.count - 4)
                                }
                            }
                        }
                    }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    let profiles = [
        UserProfile(record: MockData.profile),
        UserProfile(record: MockData.profile),
        UserProfile(record: MockData.profile),
        UserProfile(record: MockData.profile),
        UserProfile(record: MockData.profile),
        UserProfile(record: MockData.profile)
    ]
    return LocationCell(location: SpotLocation(record: MockData.location), profiles: profiles)
}
