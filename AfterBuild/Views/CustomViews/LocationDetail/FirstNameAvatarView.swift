//
//  FirstNameAvatarView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI

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

struct FirstNameAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        FirstNameAvatarView(firstName: "Martine")
    }
}
