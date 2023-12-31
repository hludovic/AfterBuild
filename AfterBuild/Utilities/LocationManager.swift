//
//  LocationManager.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import Foundation
import Observation

@Observable final class LocationManager {
    var locations: [SpotLocation] = []
    var selectedLocation: SpotLocation?
}
