//
//  LogoView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
