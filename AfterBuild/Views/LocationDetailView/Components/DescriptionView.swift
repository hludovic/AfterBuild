//
//  DescriptionView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI

struct DescriptionView: View {
    var description: String

    var body: some View {
        Text(description)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}

#Preview {
    DescriptionView(description: "Its is the description of the spot Its is the description of the spot Its is the description of the spot Its is the description of the spot")
}
