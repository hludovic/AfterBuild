//
//  CharactersRemainView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

struct CharactersRemainView: View {
    var currentCount: Int

    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(uiColor: .systemPink))
        +
        Text(" characters remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}

#Preview {
    CharactersRemainView(currentCount: 12)
}
