//
//  ForkButton.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 27/09/2023.
//

import SwiftUI

struct ForkButton: View {
    var body: some View {
        Image(systemName: "fork.knife")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 30)
            .padding(.vertical, 5)
            .background(Color.afterBuildRed)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

#Preview {
    ForkButton()
}
