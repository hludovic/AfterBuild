//
//  UIImage+Ext.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 05/09/2023.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileUrl = urlPath.appending(path: "selectedAvatarImage")
        guard let imageData = self.jpegData(compressionQuality: 0.25) else { return nil }
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
    }
}
