//
//  EditImage.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(height: 14)
            .foregroundColor(.white)
            .offset(x: 0, y: 32)
    }
}

struct EditImage_Previews: PreviewProvider {
    static var previews: some View {
        EditImage()
    }
}
