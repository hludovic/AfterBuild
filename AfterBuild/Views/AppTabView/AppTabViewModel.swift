//
//  AppTabViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/09/2023.
//

import SwiftUI
import Observation

final class AppTabViewModel: ObservableObject {
    @Published var isShowingOnboardView: Bool = false
    @AppStorage(StorageKey.hasSeenOnboardView) var hasSeenOnboardView = false {
        didSet { isShowingOnboardView = hasSeenOnboardView }
    }

    func checkIfHasSeenOnboard() {
        if !hasSeenOnboardView { hasSeenOnboardView = true }
    }
}
