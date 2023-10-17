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

    static var chipotle: CKRecord {
        let record = CKRecord(recordType: RecordType.location, recordID: CKRecord.ID(recordName: "7C8D0FCB-1B68-491E-A738-8042C098A673"))
        record[SpotLocation.kName] = "Chipotle"
        record[SpotLocation.kAddress] = "1 S Market St Ste 40"
        record[SpotLocation.kDescription] = "Our local San Jose One South Market Chipotle Mexican Grill is cultivating a better world by serving responsibly sourced, classically-cooked, real food."
        record[SpotLocation.kWebsiteURL] = "https://locations.chipotle.com/ca/san-jose/1-s-market-st"
        record[SpotLocation.kLocation] = CLLocation(latitude: 37.334967, longitude: -121.892566)
        record[SpotLocation.kPhoneNumber] = "408-938-0919"
        return record
    }

    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[UserProfile.kFirstName] = "Test"
        record[UserProfile.kLastName] = "USER"
        record[UserProfile.kCompanyName] = "Super Compagny"
        record[UserProfile.kBio] = "This is my super bio, I home it's not too long I can't check character count."
        return record
    }
}
