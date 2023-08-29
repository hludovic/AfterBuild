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
}
