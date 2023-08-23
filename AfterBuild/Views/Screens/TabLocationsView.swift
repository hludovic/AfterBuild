//
//  TabLocationsView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabLocationsView: View {
    @State private var locations: [SpotLocation] = [SpotLocation(record: MockData.location)]

    var body: some View {
        NavigationStack {
            List {
                ForEach(locations, id: \.ckRecordID) { location in
                    NavigationLink {
                        LocationDetailView(location: location)
                    } label: {
                        LocationCell(location: location)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Spots")
        }
    }
}

struct TabLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        TabLocationsView()
    }
}

