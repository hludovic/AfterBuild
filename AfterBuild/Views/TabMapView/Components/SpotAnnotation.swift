//
//  Annotation.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/09/2023.
//

import SwiftUI

struct SpotAnnotation: View {
    var location: SpotLocation
    var number: Int

    var body: some View {
        ZStack{
            MapBalloonShape()
                .frame(width: 100, height: 70)
                .foregroundStyle(.brandPrimary)
            Image(uiImage: location.createSquareImage())
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .offset(y: -11)
            if number > 0 {
                Text("\(min(number, 99))")
                    .font(.system(size: 11, weight: .bold))
                    .frame(width: 26, height: 18)
                    .background(Color.afterBuildRed)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .offset(x: 20, y: -28)
            }
        }
    }
}

#Preview {
    SpotAnnotation(location: SpotLocation(record: MockData.location), number: 38)
}
