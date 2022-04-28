//
//  SettingsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

class SettingsViewModel: ObservableObject {
    var router: SettingsRouterProtocol?
    var settingService: SettingServices
    var authenticationService: AuthenticationServiceProtocol

    @Published var guardEnabled = false {
        didSet {
            settingService.authenticationEnabled = guardEnabled
            if guardEnabled { registerNewPin() }
        }
    }

    @Published var biometricsEnabled = false {
        didSet {
            settingService.biometricsEnabled = biometricsEnabled
        }
    }

    init(settings: SettingServices = SettingServices(), authService: AuthenticationServiceProtocol = AuthenticationService()) {
        settingService = settings
        authenticationService = authService
        guardEnabled = settingService.authenticationEnabled
        biometricsEnabled = settingService.biometricsEnabled
    }

    @MainActor
    func changeBiometricStatus() async {
        if !biometricsEnabled {
            biometricsEnabled = await authenticationService.biometricAuthentication()
        } else {
            biometricsEnabled.toggle()
        }
    }

    func registerNewPin() {
        router?.registerNewPin()
    }
}
