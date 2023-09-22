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
                    Marker(location.name, coordinate: location.location.coordinate)
                        .tint(.brandPrimary)
                }
                UserAnnotation()
            }

            HStack {
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
                }
                .foregroundStyle(.white)
                .symbolVariant(.fill)
                .labelStyle(.iconOnly)
                .tint(.afterBuildRed)
                .clipShape(Capsule())
                .padding()

                Button {
                    viewModel.position = .automatic
                } label: {
                    Image(systemName: "fork.knife.circle.fill")
                        .resizable()
                        .background(.white)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.afterBuildRed)
                        .clipShape(Circle())
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

#Preview {
    TabMapView()
        .environmentObject(LocationManager())
}
