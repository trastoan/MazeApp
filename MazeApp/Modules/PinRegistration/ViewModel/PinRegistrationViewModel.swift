//
//  PinRegistrationViewModel.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

protocol PinRegistrationViewModelProtocol {
    var failedConfirmation: (() -> Void)? { get set }
    func cancelRegistration()
    func storePin(_ value: String)
    func checkPin(_ value: String)
}

class PinRegistrationViewModel: PinRegistrationViewModelProtocol {
    var router: PinRegistrationRouterProtocol
    var failedConfirmation: (() -> Void)?
    var authService: AuthenticationService

    private var registeredPin: String

    init(router: PinRegistrationRouterProtocol, registeredPin: String = "", auth: AuthenticationService = AuthenticationService()) {
        self.router = router
        self.registeredPin = registeredPin
        self.authService = auth
    }

    func cancelRegistration() {
        router.dismissController()
    }

    func storePin(_ value: String) {
        registeredPin = value
    }

    func checkPin(_ value: String) {
        if registeredPin == value {
            _ = authService.savePin(value)
            router.dismissController()
        } else {
            failedConfirmation?()
        }
    }
}
