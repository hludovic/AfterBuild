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

extension View {
    @ViewBuilder func alertMessage(item: AlertItem?, isPresented: Binding<Bool>) -> some View {
        if let item {
            self.alert(item.title, isPresented: isPresented) {
            } message: { item.message }
        } else { self }
    }
}
