//
//  SettingsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

class SettingsViewModel: ObservableObject {
    var router: SettingsRouter?

    @Published var guardEnabled = false {
        didSet {
            UserDefaults.standard.set(guardEnabled, forKey: UserDefaults.authenticationEnabledKey)
            if guardEnabled { registerNewPin() }
        }
    }

    @Published var biometricsEnabled = false {
        didSet {
            UserDefaults.standard.set(biometricsEnabled, forKey: UserDefaults.biometricEnabledKey)
        }
    }

    init() {
        guardEnabled = UserDefaults.authenticationEnabled
        biometricsEnabled = UserDefaults.biometricsEnabled
    }

    @MainActor
    func changeBiometricStatus() {
        if !biometricsEnabled {

        } else {
            biometricsEnabled.toggle()
        }
    }

    func registerNewPin() {
        router?.registerNewPin()
    }
}
