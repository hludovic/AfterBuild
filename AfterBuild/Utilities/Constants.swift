//
//  Constants.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import UIKit

enum RecordType {
    static let location = "SpotLocation"
    static let profile = "UserProfile"
}

enum PlaceholderImage {
    static let avatar = UIImage(resource: .defaultAvatar)
    static let square = UIImage(resource: .defaultSquareAsset)
    static let banner = UIImage(resource: .defaultBannerAsset)
}

enum ImageDimention {
    case square, banner

    static func getPlaceholder(for dimention: ImageDimention) -> UIImage {
        return dimention == .square ? PlaceholderImage.square : PlaceholderImage.banner
    }
}

enum StorageKey {
    static let hasSeenOnboardView = "HasSeenOnboardView"
}

extension SpotLocation {
    static let kName = "name"
    static let kAddress = "address"
    static let kDescription = "description"
    static let kBannerAsset = "bannerAsset"
    static let kSquareAsset = "squareAsset"
    static let kLocation = "location"
    static let kWebsiteURL = "websiteURL"
    static let kPhoneNumber = "phoneNumber"
}

extension UserProfile {
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kCompagnyName = "compagnyName"
    static let kBio = "bio"
    static let kAvatar = "avatar"
    static let kIsCheckedIn = "isCheckedIn"
}
