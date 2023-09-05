//
//  AlertItem.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id  = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let unableToGetLocations = AlertItem(
        title: Text("Location Error"),
        message: Text("Unable to retrive locationsat this time.\nPlease try again."),
        dismissButton: .default(Text("Ok")))

    static let locationRestricted = AlertItem(
        title: Text("Location Restricted"),
        message: Text("Your location is restricted. This may be due to parental controls."),
        dismissButton: .default(Text("Ok")))

    static let locationDenied = AlertItem(
        title: Text("Location Denied"),
        message: Text("AfterBuild does not have permition to access your location. Check your phone settings"),
        dismissButton: .default(Text("Ok")))
    
    static let locationDisabled = AlertItem(
        title: Text("Location Service Disabled"),
        message: Text("Your phone location services are disebled. To change that go on your phone privacy settings"),
        dismissButton: .default(Text("Ok")))
}
