//
//  LocationButtonStyle.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 27/09/2023.
//

import SwiftUI

struct LocationButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .background(Color.brandSecondary)
            .tint(.brandSecondary)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
