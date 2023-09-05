//
//  LocationActionButton.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI

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

struct LocationActionButton_Previews: PreviewProvider {
    static var previews: some View {
        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
    }
}
