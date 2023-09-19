//
//  FirstNameAvatarView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI

struct FirstNameAvatarView: View {
    var profile: UserProfile

    var body: some View {
        VStack {
            AvatarView(size: 65, image: profile.getAvatar())
            Text(profile.firstName)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct FirstNameAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        FirstNameAvatarView(profile: UserProfile(record: MockData.profile))
    }
}
