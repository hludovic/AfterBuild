//
//  OnboardInfoView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 05/09/2023.
//

import SwiftUI

struct OnboardInfoView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)

            VStack(alignment: .leading, spacing: 3) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}

struct OnboardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardInfoView(
            imageName: "building.2.crop.circle",
            title: "Restaurant Locations",
            description: "Find places to dine around around Jarry in Guadeloupe"
        )
    }
}
