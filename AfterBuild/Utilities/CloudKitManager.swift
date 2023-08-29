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
}
