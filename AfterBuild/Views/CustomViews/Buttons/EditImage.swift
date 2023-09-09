//
//  EditImage.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct EditImage: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .opacity(0.7)
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
                .foregroundColor(.brandPrimary)
                .opacity(0.7)
        }
        .offset(x: 32, y: 24)

    }
}

struct EditImage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            EditImage()
        }
    }
}
