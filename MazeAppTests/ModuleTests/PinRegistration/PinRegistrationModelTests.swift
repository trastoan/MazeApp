//
//  PinRegistrationModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

class PinRegistrationModelTests: XCTestCase {
    var sut: PinRegistrationViewModel!
    var spyRouter: SpyPinRegistrationRouter!
    var spyAuth: SpyAuthService!
    var keychainService: KeychainService!
    var hasFailedConfirmation = false

    override func setUp() {
        spyRouter = SpyPinRegistrationRouter()
        spyAuth = SpyAuthService()
        keychainService = KeychainService()
        keychainService.account = "TestAccount"
        sut = PinRegistrationViewModel(router: spyRouter, auth: spyAuth)
        setupCallBack()
    }

    override func tearDown() {
        spyAuth = nil
        spyRouter = nil
        sut = nil
        _ = keychainService.delete(service: KeychainService.pinService)
        hasFailedConfirmation = false
    }

    func test_cancelRegistration_shouldDismissController_pinUnchanged() {
        let defaultPinData = "1234".data(using: .utf8)!
        let _ = keychainService.save(defaultPinData, service: KeychainService.pinService)
        sut.cancelRegistration()

        XCTAssertTrue(spyRouter.hasDissmissed)

        let savedPin = keychainService.read(service: KeychainService.pinService)
        XCTAssertEqual(defaultPinData, savedPin)
    }

    func test_storePin_willPersistValue() {
        let pinToBeStored = "1234"

        sut.storePin(pinToBeStored)

        XCTAssertEqual(pinToBeStored, sut.registeredPin)
    }

    func test_differentPinInput_failsConfirmation() {
        let pinToBeStored = "1234"

        sut.storePin(pinToBeStored)

        sut.checkPin("3343")

        XCTAssertTrue(hasFailedConfirmation)
    }

    func test_samePin_passConfirmation_dismissController() {
        let pinToBeStored = "1234"

        sut.storePin(pinToBeStored)

        sut.checkPin("1234")

        XCTAssertTrue(spyRouter.hasDissmissed)

    }

    func setupCallBack() {
        sut.failedConfirmation = { [weak self] in
            self?.hasFailedConfirmation = true
        }
    }
}

