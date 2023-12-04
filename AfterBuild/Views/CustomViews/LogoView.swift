//
//  LogoView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct LogoView: View {
    var frameWidth: CGFloat

    var body: some View {
        Image(.cleanLogo)
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

#Preview {
    LogoView(frameWidth: 250)
}
