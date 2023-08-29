//
//  CKRecord+Ext.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 24/08/2023.
//

import CloudKit

extension CKRecord {
    func convertToSpotLocation() -> SpotLocation { SpotLocation(record: self) }
    func convertToUserProfile() -> UserProfile { UserProfile(record: self) }
}
