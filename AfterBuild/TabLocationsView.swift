//
//  TabLocationsView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI

struct TabLocationsView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach( 0..<5) { item in
                    HStack {
                        Image("default-square-asset")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.vertical, 7)

                        VStack(alignment: .leading) {
                            Text("Test Location Name")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                            HStack {
                                AvatarView(size: 35)
                                AvatarView(size: 35)
                                AvatarView(size: 35)
                                AvatarView(size: 35)
                                AvatarView(size: 35)
                            }
                        }
                        .padding(.leading)

                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Spots")
        }
    }
}

struct TabLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        TabLocationsView()
    }
}

struct AvatarView: View {
    var size: CGFloat

    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}
