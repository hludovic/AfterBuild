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
                    Annotation(location.name, coordinate: location.location.coordinate, anchor: .bottom) {
                        SpotAnnotation(location: location)
                            .onTapGesture {
                                locationManager.selectedLocation = location
                                viewModel.isShowingDetailView = true
                            }
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
                .modifier(LocationButtonStyle())
                .padding()

                Button {
                    withAnimation { viewModel.position = .automatic }
                } label: {
                    ForkButton()
                }
                Spacer()
            }
        }
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            if let location = locationManager.selectedLocation {
                NavigationStack {
                    LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                        .toolbarTitleDisplayMode(.inline)
                        .toolbar {
                            Button {
                                viewModel.isShowingDetailView =  false
                            } label: {
                                Text("Close")
                            }
                        }
                }
            }
        }
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
    }
}

#Preview {
    TabMapView()
        .environmentObject(LocationManager())
}
