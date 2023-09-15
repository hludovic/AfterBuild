//
//  CKAsset+Ext.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 01/09/2023.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIimage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholder(for: dimension)
        guard let fileURL else { return placeholder }
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
