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
    // MARK: - TabMapView Errors
    static let unableToGetLocations = AlertItem(
        title: Text("Location Error"),
        message: Text("Unable to retrive locationsat this time.\nPlease try again."))

    static let locationRestricted = AlertItem(
        title: Text("Location Restricted"),
        message: Text("Your location is restricted. This may be due to parental controls."))

    static let locationDenied = AlertItem(
        title: Text("Location Denied"),
        message: Text("AfterBuild does not have permition to access your location. Check your phone settings."))

    // MARK: - TabProfile Errors
    static let invalidProfile = AlertItem(
        title: Text("Invalid Profile"),
        message: Text("All fields are required as well ass profile photo. Your bio must be < 100 characters.\nPlease try again."))

    static let noUserRecord = AlertItem(
        title: Text("No User Record"),
        message: Text("You must log into iCloud on your phone in order to utilize AfterBuild's Profile. Please log in your settings screen."))

    static let createProfileSuccess = AlertItem(
        title: Text("Profile Created Successfully"),
        message: Text("Your profile has successfully been created"))

    static let createProfileFailure = AlertItem(
        title: Text("Failed to Create Profile"),
        message: Text("We were unable to create your profile at this time.\nPlease try again later or contact customer support if this persist."))

    static let getProfileFailure = AlertItem(
        title: Text("Unable to Retrive Profile"),
        message: Text("We were unable to retrive your profile at this time.\nPlease try again later or contact customer support if this persist."))

    static let updateProfileSuccess = AlertItem(
        title: Text("Profile Update Success"),
        message: Text("Your AfterBuild Profile was updated successfully."))

    static let updateProfileFailure = AlertItem(
        title: Text("Profile Update Failed"),
        message: Text("We were unable to update your profile at this time.\nPlease try again later."))

    // MARK: - LocationDetail Errors
    static let wrongPhoneNumber = AlertItem(
        title: Text("Invalid Phone Number"),
        message: Text("The phone number for the location is invalid. Please look up the phone number yourself."))

    static let unableToGetCheckInStatus = AlertItem(
        title: Text("Server Error"),
        message: Text("Unable to retrieve checked in status of the current user.\nPlease try again"))

    static let unableToCheckInOut = AlertItem(
        title: Text("Server Error"),
        message: Text("Unable to check in/out at this time.\nPlease try again"))

    static let unableToGetCheckedInProfiles = AlertItem(
        title: Text("Server Error"),
        message: Text("We are unable to get users checked into this location at this time.\nPlease try again"))
}
