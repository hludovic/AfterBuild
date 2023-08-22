//
//  ButtonText.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct ButtonText: View {
    var title: String

    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .foregroundColor(.white)
            .background(Color.brandPrimary)
            .cornerRadius(8)
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonText(title: "Button Text")
    }
}
