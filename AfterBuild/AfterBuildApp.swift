//
//  AfterBuildApp.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

@main
struct AfterBuildApp: App {
    let locationManager: LocationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(locationManager)
        }
    }
}
