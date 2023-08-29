//
//  TabMapView.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 18/08/2023.
//

import SwiftUI
import MapKit

struct TabMapView: View {

    @StateObject var viewModel = TabMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.coordonateRegion)
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                LogoView().shadow(radius: 10)
                Spacer()
            }
        }
        .onAppear{
            viewModel.getLocations()
        }
        .toolbarBackground(.visible, for: .tabBar)
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
    }
}

struct TabMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabMapView()
    }
}
