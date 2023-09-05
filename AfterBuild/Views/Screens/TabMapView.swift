//
//  TabMapView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI
import MapKit

struct TabMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject var viewModel = TabMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.coordonateRegion,showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
            }
            .ignoresSafeArea()
            .tint(.afterBuildRed)
            VStack {
                LogoView(frameWidth: 125).shadow(radius: 10)
                Spacer()
            }
        }
        .onAppear{
            viewModel.runStartumCheck()
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
        .sheet(
            isPresented: $viewModel.isShowingOnboardView,
            onDismiss: { viewModel.startLocationService() },
            content: {
                OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
                    .presentationDragIndicator(.visible)
            }
        )
        .toolbarBackground(.visible, for: .tabBar)
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
    }
}

struct TabMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabMapView()
            .environmentObject(LocationManager())
    }
}
