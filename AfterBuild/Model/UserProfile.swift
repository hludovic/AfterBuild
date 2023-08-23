//
//  UserProfile.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit

struct UserProfile {
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kCompagnyName = "compagnyName"
    static let kBio = "bio"
    static let kAvatar = "avatar"
    static let kIsCheckedIn = "isCheckedIn"

    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let compagnyName: String
    let bio: String
    let avatar: CKAsset!
    let isCheckedIn: CKRecord.Reference? = nil

    init(record: CKRecord) {
        ckRecordID = record.recordID
        firstName = record[UserProfile.kFirstName] as? String ?? "N/A"
        lastName = record[UserProfile.kLastName] as? String ?? "N/A"
        compagnyName = record[UserProfile.kCompagnyName] as? String ?? "N/A"
        bio = record[UserProfile.kBio] as? String ?? "N/A"
        avatar = record[UserProfile.kAvatar] as? CKAsset
    }

}
