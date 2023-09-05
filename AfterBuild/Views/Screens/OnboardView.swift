//
//  OnboardView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 03/09/2023.
//

import SwiftUI

struct OnboardView: View {
@Binding var isShowingOnboardView: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardView.toggle()
                } label: {
                    DismissButton()
                }
            }
            Spacer()
            LogoView(frameWidth: 250).padding(.bottom)

            VStack(alignment: .leading, spacing: 30) {
                OnboardInfoView(imageName: "building.2.crop.circle", title: "Restaurant Locations", description: "Find places to dine around around Jarry in Guadeloupe")
                OnboardInfoView(imageName: "checkmark.circle", title: "Check In", description: "Let other Developpers know where you are")
                OnboardInfoView(imageName: "person.2.circle", title: "Find Frends", description: "See where auther deeveloppers are and join the party")
            }
            .padding(.horizontal, 40)
            Spacer()
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(isShowingOnboardView: .constant(true))
    }
}

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
