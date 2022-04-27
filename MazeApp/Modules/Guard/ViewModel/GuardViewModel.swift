//
//  GuardViewModel.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

protocol GuardViewModelProtocol {
    var settingsService: SettingServices { get set }
    var defaultAuthentication: (() -> Void)? { get set }
    var failedToAuthenticate: (() -> Void)? { get set }

    func authenticateUser() async
    func pinAuthentication(passcode: String)
}

class GuardViewModel: GuardViewModelProtocol {
    var router: GuardRouterProtocol
    var settingsService = SettingServices()
    var authService: AuthenticationServiceProtocol
    var defaultAuthentication: (() -> Void)?
    var failedToAuthenticate: (() -> Void)?

    init(router: GuardRouterProtocol, authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.router = router
        self.authService = authService
    }

    @MainActor
    func authenticateUser() async {
        if settingsService.biometricsEnabled {
//            Task {
                if await authService.biometricAuthentication() {
                    router.dismissController()
                } else {
                    defaultAuthentication?()
                }
//            }
        } else {
            defaultAuthentication?()
        }
    }

    func pinAuthentication(passcode: String) {
        if authService.pinAuthentication(passcode, service: KeychainService.pinService) {
            self.router.dismissController()
        } else {
            failedToAuthenticate?()
        }
    }
}
