//
//  TabLocationsView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabLocationsView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach( 0..<10) { item in
                    NavigationLink {
                        LocationDetailView()
                    } label: {
                        LocationCell()
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

