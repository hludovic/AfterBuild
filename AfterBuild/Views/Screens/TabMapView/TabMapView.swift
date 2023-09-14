//
//  TabMapView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import CoreLocationUI
import SwiftUI
import MapKit

struct TabMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject var viewModel = TabMapViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Map {
                ForEach(locationManager.locations) { location in
                    Marker(location.name, coordinate: location.location.coordinate)
                        .tint(.brandPrimary)
                    UserAnnotation()
                }
            }
            .mapControls {
                MapPitchToggle()
                MapUserLocationButton()
            }
//            Map(coordinateRegion: $viewModel.coordonateRegion,
//                showsUserLocation: true,
//                annotationItems: locationManager.locations) { location in
//                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
//            }
//            .ignoresSafeArea()
            .tint(.afterBuildRed)

            LogoView(frameWidth: 125).shadow(radius: 10)

        }
        .onAppear {
            viewModel.checkIfHasSeenOnboard()
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
        .overlay(alignment: .bottomLeading) {
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundStyle(.white)
            .symbolVariant(.fill)
            .tint(.afterBuildRed)
            .labelStyle(.iconOnly)
            .clipShape(Circle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0))
        }
        .sheet(
            isPresented: $viewModel.isShowingOnboardView,
            content: {
                OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
                    .presentationDragIndicator(.visible)
            }
        )
        .toolbarBackground(.visible, for: .tabBar)
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
    }
}

struct TabMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabMapView()
            .environmentObject(LocationManager())
    }
}
