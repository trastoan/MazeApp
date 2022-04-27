//
//  GuardModelSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import UIKit
@testable import MazeApp

class SpyGuardRouter: GuardRouterProtocol {
    var hasDismissedScreen: Bool = false

    static func assembleModule() -> UIViewController {
        return UIViewController()
    }

    func dismissController() {
        hasDismissedScreen = true
    }

}

class SpyAuthService: AuthenticationServiceProtocol {
    var keychainService = KeychainService()
    var hasCalledBiometrics = false
    var correctPin = "12345"
    var shouldFailBiometric = false

    func biometricAuthentication() async -> Bool {
        hasCalledBiometrics = true
        return !shouldFailBiometric
    }

    func savePin(_ value: String, service: String) -> Bool {
        value == correctPin
    }

    func pinAuthentication(_ pin: String, service: String) -> Bool {
        pin == correctPin
    }
}
