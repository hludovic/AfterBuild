//
//  AddressView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/08/2023.
//

import SwiftUI


struct AddressView: View {
    var address: String

    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

#Preview {
    AddressView(address: "1 S Market St Ste 40")
}
