//
//  View+Ext.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 22/08/2023.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameStyle())
    }
}

