//
//  MapBalloonShape.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 21/09/2023.
//

import SwiftUI

struct MapBalloonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.minY))


        return path
    }
}

#Preview {
    MapBalloonShape()
        .frame(width: 300, height: 240)
}
