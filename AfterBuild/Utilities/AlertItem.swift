//
//  AlertItem.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/08/2023.
//

import SwiftUI

struct AlertItem {
    let title: Text
    let message: Text
}

struct AlertContext {
    // MARK - TabMapView Errors
    static let unableToGetLocations = AlertItem(
        title: Text("Location Error"),
        message: Text("Unable to retrive locationsat this time.\nPlease try again."))

    static let locationRestricted = AlertItem(
        title: Text("Location Restricted"),
        message: Text("Your location is restricted. This may be due to parental controls."))

    static let locationDenied = AlertItem(
        title: Text("Location Denied"),
        message: Text("AfterBuild does not have permition to access your location. Check your phone settings."))

//    static let locationDisabled = AlertItem(
//        title: Text("Location Service Disabled"),
//        message: Text("Your phone location services are disebled. To change that go on your phone privacy settings"))

    // MARK - TabProfile Errors
    static let invalidProfile = AlertItem(
        title: Text("Invalid Profile"),
        message: Text("All fields are required as well ass profile photo. Your bio must be < 100 characters.\nPlease try again."))

}
