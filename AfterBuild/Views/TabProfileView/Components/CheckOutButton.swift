//
//  CheckOutButton.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 19/10/2023.
//

import SwiftUI

struct CheckOutButton: View {
    var body: some View {
        Label("Check Out", systemImage: "mappin.and.ellipse")
            .foregroundStyle(Color.white)
            .font(.system(size: 12, weight: .semibold))
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .background(Color.afterBuildRed)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CheckOutButton()
}
