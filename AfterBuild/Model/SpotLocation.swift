//
//  SpotLocation.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit

struct SpotLocation {
    static let kName = "name"
    static let kAddress = "address"
    static let kDescription = "description"
    static let kBannerAsset = "bannerAsset"
    static let kSquareAsset = "squareAsset"
    static let kLocation = "location"
    static let kWebsiteURL = "websiteURL"
    static let kPhoneNumber = "phoneNumber"

    let ckRecordID: CKRecord.ID
    let name: String
    let address: String
    let description: String
    let bannerAsset: CKAsset!
    let squareAsset: CKAsset!
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String

    init(record: CKRecord) {
        ckRecordID = record.recordID
        name = record[SpotLocation.kName] as? String ?? "N/A"
        address = record[SpotLocation.kAddress] as? String ?? "N/A"
        description = record[SpotLocation.kDescription] as? String ?? "N/A"
        bannerAsset = record[SpotLocation.kBannerAsset] as? CKAsset
        squareAsset = record[SpotLocation.kSquareAsset] as? CKAsset
        location = record[SpotLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[SpotLocation.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[SpotLocation.kPhoneNumber] as? String ?? "N/A"
    }
}
