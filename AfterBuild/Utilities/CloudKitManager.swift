//
//  CloudKitManager.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import CloudKit

class CloudKitManager {
    static let shared = CloudKitManager()

    private init() {}

    let container = CKContainer.default()
    var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID?

    func getLocations() async throws -> [SpotLocation] {
        let sortDescriptor = NSSortDescriptor(key: SpotLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        let (matching, _) = try await container.publicCloudDatabase.records(matching: query)
        let records = matching.compactMap { _, result in try? result.get() }
        return records.map(SpotLocation.init)
    }

    func getUserRecord() async throws {
        let recordID = try await container.userRecordID()
        let record = try await container.publicCloudDatabase.record(for: recordID)
        userRecord = record
        if let profileReferance = record["userProfile"] as? CKRecord.Reference {
            profileRecordID = profileReferance.recordID
        }
    }

    func save(records: [CKRecord]) async throws -> [CKRecord] {
        let (saveResults, _) = try await container.publicCloudDatabase.modifyRecords(saving: records, deleting: [])
        return saveResults.compactMap { (_ , result) in try? result.get() }
    }

    func save(record: CKRecord) async throws -> CKRecord {
        try await container.publicCloudDatabase.save(record)
    }

    func fetchRecord(with id: CKRecord.ID) async throws -> CKRecord {
        return try await container.publicCloudDatabase.record(for: id)
    }

    func getCheckInProfiles(for locationID: CKRecord.ID) async throws -> [UserProfile] {
        let reference = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate = NSPredicate(format: "isCheckedIn == %@", reference)
        let querry = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let (results, _) = try await container.publicCloudDatabase.records(matching: querry)
        let resultRecords = results.compactMap { try? $1.get() }
        return resultRecords.map(UserProfile.init)
    }

    func getUserProfilesChecked(in locations: [SpotLocation]) async throws -> [UserProfile] {
        let locationsReference = locations.map { CKRecord.Reference(recordID: $0.id, action: .none) }
        let predicate = NSPredicate(format: "\(UserProfile.kIsCheckedIn) in %@", locationsReference)
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let (results, cursor) = try await container.publicCloudDatabase.records(matching: query)
        if let cursor { print(cursor) }
        let usersRecord = results.compactMap { try? $1.get() }
        return usersRecord.map { UserProfile(record: $0) }
    }
}
