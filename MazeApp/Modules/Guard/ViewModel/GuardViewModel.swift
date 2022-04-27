//
//  GuardViewModel.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

protocol GuardViewModelProtocol {
    var defaultAuthentication: (() -> Void)? { get set }
    var failedToAuthenticate: (() -> Void)? { get set }

    func authenticateUser()
    func pinAuthentication(passcode: String)
}

class GuardViewModel: GuardViewModelProtocol {
    var router: GuardRouterProtocol
    var defaultAuthentication: (() -> Void)?
    var failedToAuthenticate: (() -> Void)?

    init(router: GuardRouterProtocol) {
        self.router = router
    }

    @MainActor
    func authenticateUser() {
        if UserDefaults.biometricsEnabled {
            Task {
                if await AuthenticationService.shared.biometricAuthentication() {
                    router.dismissController()
                } else {
                    defaultAuthentication?()
                }
            }
        } else {
            defaultAuthentication?()
        }
    }

    func pinAuthentication(passcode: String) {
        if AuthenticationService.shared.pinAuthentication(passcode) {
            self.router.dismissController()
        } else {
            failedToAuthenticate?()
        }
    }
}
