//
//  MockData.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[SpotLocation.kName] = "Restaurant Name"
        record[SpotLocation.kAddress] = "123 Queen Street"
        record[SpotLocation.kDescription] = "This is the description blablabla Nice description. The description describe one location that have to be described"
        record[SpotLocation.kLocation] = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[SpotLocation.kWebsiteURL] = "https://hludovic.fr"
        record[SpotLocation.kPhoneNumber] = "+590 690 12 34 56"
        return record
    }

    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[UserProfile.kFirstName] = "Test"
        record[UserProfile.kLastName] = "USER"
        record[UserProfile.kCompagnyName] = "Super Compagny"
        record[UserProfile.kBio] = "This is my super bio, I home it's not too long I can't check character count."
        return record
    }
}
