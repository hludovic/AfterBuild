//
//  TabLocationsView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabLocationsView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @ObservedObject var viewModel = TabLocationsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink {
                        LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                    } label: {
                        LocationCell(
                            location: location,
                            profiles: viewModel.checkedInProfiles[location.id, default: []]
                        )
                    }
                }
            }
            .task { await viewModel.getCheckedInProfiles(in: locationManager.locations) }
            .toolbarBackground(.visible, for: .tabBar)
            .navigationTitle("Spots")
        }
    }
}

#Preview {
    func previewLocationManager() -> LocationManager {
        let locations = [ SpotLocation(record: MockData.location),
                          SpotLocation(record: MockData.location),
                          SpotLocation(record: MockData.location),
                          SpotLocation(record: MockData.location),
                          SpotLocation(record: MockData.location),
                          SpotLocation(record: MockData.location)
        ]
        let locaitionManager = LocationManager()
        locaitionManager.locations = locations
        return locaitionManager
    }
    
    return TabLocationsView()
        .environmentObject(previewLocationManager())
}

