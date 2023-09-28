//
//  AppTabView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct AppTabView: View {
    @StateObject var viewModel: AppTabViewModel = AppTabViewModel()

    var body: some View {
        TabView {
            TabMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            TabLocationsView()
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            NavigationStack {
                TabProfileView()
            }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .task {
            try? await CloudKitManager.shared.getUserRecord()
            viewModel.checkIfHasSeenOnboard()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView) {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppTabView(viewModel: AppTabViewModel())
        .environmentObject(LocationManager())
}
