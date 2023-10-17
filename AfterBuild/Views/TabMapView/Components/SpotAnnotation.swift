//
//  Annotation.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 23/09/2023.
//

import SwiftUI
import CloudKit

struct SpotAnnotation: View {
    var location: SpotLocation
    var viewModel: TabMapViewModel

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
            if viewModel.checkedInCount[location.id, default: 0] > 0 {
                Text("\(min(viewModel.checkedInCount[location.id, default: 0], 99))")
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
    let viewModel = TabMapViewModel()
    viewModel.checkedInCount = [CKRecord.ID(recordName: "7C8D0FCB-1B68-491E-A738-8042C098A673"): 30]
    return SpotAnnotation(location: SpotLocation(record: MockData.chipotle), viewModel: viewModel)
}
