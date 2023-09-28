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
            .scaledToFit()
            .frame(width: 50, height: 30)
            .padding(.vertical, 5)
            .background(Color.afterBuildRed)
            .tint(.afterBuildRed)
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .labelStyle(.iconOnly)
            .clipShape(Capsule())
    }
}
