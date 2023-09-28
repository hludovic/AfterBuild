//
//  LocationManager.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [SpotLocation] = []
    var selectedLocation: SpotLocation?
}
