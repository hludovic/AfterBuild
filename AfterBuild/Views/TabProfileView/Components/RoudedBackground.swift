//
//  RoudedBackground.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct RoudedBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 130)
            .foregroundColor(Color(uiColor: .secondarySystemBackground))
    }
}

#Preview {
    RoudedBackground()
}
