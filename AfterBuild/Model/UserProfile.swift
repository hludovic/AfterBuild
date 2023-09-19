//
//  UserProfile.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit
import UIKit

struct UserProfile: Identifiable {
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let compagnyName: String
    let bio: String
    let avatar: CKAsset!
    let isCheckedIn: CKRecord.Reference? = nil

    init(record: CKRecord) {
        id = record.recordID
        firstName = record[UserProfile.kFirstName] as? String ?? "N/A"
        lastName = record[UserProfile.kLastName] as? String ?? "N/A"
        compagnyName = record[UserProfile.kCompanyName] as? String ?? "N/A"
        bio = record[UserProfile.kBio] as? String ?? "N/A"
        avatar = record[UserProfile.kAvatar] as? CKAsset
    }

    func getAvatar() -> UIImage {
        guard let avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIimage(in: .square)
    }
}
