//
//  TabLocationsView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabLocationsView: View {

    @EnvironmentObject private var locationManager: LocationManager

    var body: some View {
        NavigationStack {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink {
                        LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                    } label: {
                        LocationCell(location: location)
                    }
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .navigationTitle("Spots")
        }
    }
}

struct TabLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        TabLocationsView()
            .environmentObject(LocationManager())
    }
}

