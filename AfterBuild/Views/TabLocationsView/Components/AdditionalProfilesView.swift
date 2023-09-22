//
//  AdditionalProfilesView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 21/09/2023.
//

import SwiftUI

struct AdditionalProfilesView: View {
    var number: Int
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .background(.brandPrimary)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
}

#Preview {
    AdditionalProfilesView(number: 2)
}
