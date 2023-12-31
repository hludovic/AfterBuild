//
//  SpotLocation.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit
import UIKit

struct SpotLocation: Identifiable {
    let id: CKRecord.ID
    let name: String
    let address: String
    let description: String
    let bannerAsset: CKAsset!
    let squareAsset: CKAsset!
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String

    init(record: CKRecord) {
        id = record.recordID
        name = record[SpotLocation.kName] as? String ?? "N/A"
        address = record[SpotLocation.kAddress] as? String ?? "N/A"
        description = record[SpotLocation.kDescription] as? String ?? "N/A"
        bannerAsset = record[SpotLocation.kBannerAsset] as? CKAsset
        squareAsset = record[SpotLocation.kSquareAsset] as? CKAsset
        location = record[SpotLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[SpotLocation.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[SpotLocation.kPhoneNumber] as? String ?? "N/A"
    }

    func createSquareImage() -> UIImage {
        guard let squareAsset else { return PlaceholderImage.square }
        return squareAsset.convertToUIimage(in: .square)
    }

    func createBannerImage() -> UIImage {
        guard let bannerAsset else { return PlaceholderImage.banner }
        return bannerAsset.convertToUIimage(in: .banner)
    }
}
