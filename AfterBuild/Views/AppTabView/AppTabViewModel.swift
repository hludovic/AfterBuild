//
//  AppTabViewModel.swift
//  AfterBuild
//
//  Created by Ludovic HENRY on 28/09/2023.
//

import SwiftUI
import Observation

@Observable final class AppTabViewModel {
    var isShowingOnboardView: Bool = false
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.hasSeenOnboardView)
    }

    func checkIfHasSeenOnboard() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.setValue(true, forKey: StorageKey.hasSeenOnboardView)
        }
    }
}
