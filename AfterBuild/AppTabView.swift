//
//  AppTabView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct AppTabView: View {
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
            TabProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.brandPrimary)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
