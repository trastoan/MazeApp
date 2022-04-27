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

    private var registeredPin: String

    init(router: PinRegistrationRouterProtocol, registeredPin: String = "") {
        self.router = router
        self.registeredPin = registeredPin
    }

    func cancelRegistration() {
        router.dismissController()
    }

    func storePin(_ value: String) {
        registeredPin = value
    }

    func checkPin(_ value: String) {
        if registeredPin == value {
            _ = AuthenticationService.shared.savePin(value)
            router.dismissController()
        } else {
            failedConfirmation?()
        }
    }
}
