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
        ZStack(alignment: .bottom) {
            Map(position: $viewModel.position) {
                ForEach(locationManager.locations, id: \.id) { location in
                    Annotation(location.name, coordinate: location.location.coordinate) {
                        SpotAnnotation(location: location)
                    }
                }
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            HStack {
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
                }
                .scaledToFit()
                .frame(width: 50, height: 30)
                .padding(.vertical, 5)
                .background(Color.afterBuildRed)
                .tint(.afterBuildRed)
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .labelStyle(.iconOnly)
                .clipShape(Capsule())
                .padding(5)

                Button {
                    withAnimation { viewModel.position = .automatic }
                } label: {
                    ForkButton()
                }
                Spacer()
            }
        }
        .onAppear {
            viewModel.checkIfHasSeenOnboard()
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView,
                content: { OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView) }
        )
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
    }
}

#Preview {
    TabMapView()
        .environmentObject(LocationManager())
}
