//
//  LoadingView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 08/09/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(.circular)
                .tint(.brandPrimary)
                .scaleEffect(2)
                .offset(y: -40)
        }
    }
}

#Preview {
    LoadingView()
}
