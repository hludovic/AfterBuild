//
//  TabMapView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI
import MapKit

struct TabMapView: View {
    @State private var coordonateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 37.331516, longitude: -121.891054),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    var body: some View {
        ZStack {
            Map(coordinateRegion: $coordonateRegion)
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                LogoView().shadow(radius: 10)
                Spacer()
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct TabMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabMapView()
    }
}