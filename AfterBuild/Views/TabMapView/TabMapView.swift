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
    @Environment(LocationManager.self) private var locationManager
    @State private var viewModel = TabMapViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $viewModel.position) {
                ForEach(locationManager.locations, id: \.id) { location in
                    Annotation(location.name, coordinate: location.location.coordinate, anchor: .bottom) {
                        SpotAnnotation(location: location, viewModel: viewModel)
                        .onTapGesture {
                            locationManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                    }
                    .annotationTitles(.visible)
                }
                UserAnnotation()
            }
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            HStack {
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
                }
                .modifier(LocationButtonStyle())
                .padding()

                Button(action: { withAnimation { viewModel.position = .automatic } }, label: { ForkButton() })

                Spacer()
            }
        }
        .onAppear {
            viewModel.startupTasks(with: locationManager)
        }
        .sheet(
            isPresented: $viewModel.isShowingDetailView,
            onDismiss: { Task{ await viewModel.getCheckdedInCount(with: locationManager) } },
            content: {
                if let location = locationManager.selectedLocation {
                    NavigationStack {
                        LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                            .toolbarTitleDisplayMode(.inline)
                            .toolbar { Button("Close") { viewModel.isShowingDetailView =  false } }
                    }
                }
            }
        )
        .alertMessage(item: viewModel.alertItem, isPresented: $viewModel.isShowingAlert)
    }
}

#Preview {
    TabMapView()
        .environment(LocationManager())
}
