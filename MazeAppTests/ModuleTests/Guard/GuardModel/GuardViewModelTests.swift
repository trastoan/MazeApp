//
//  GuardViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

class GuardViewModelTests: XCTestCase {
    var sut: GuardViewModel!
    var spyRouter: SpyGuardRouter!
    var settingsService: SettingServices!
    var authService: SpyAuthService!
    var hasCalledDefaultAuth = false
    var failedToAuth = false

    override func setUp() {
        spyRouter = SpyGuardRouter()
        authService = SpyAuthService()
        sut = GuardViewModel(router: spyRouter, authService: authService)
        let defaults = UserDefaults(suiteName: "TestSuit")!
        settingsService = SettingServices(defaults: defaults)
        sut.settingsService = settingsService
        setupCallBacks()
    }

    override func tearDown() {
        spyRouter = nil
        authService = nil
        sut = nil
        settingsService = nil
        hasCalledDefaultAuth = false
        failedToAuth = false
        UserDefaults().removePersistentDomain(forName: "TestSuit")
    }

    func test_biometricsEnabled_callBioAuth() async {
        settingsService.biometricsEnabled = true
        authService.shouldFailBiometric = false

        await sut.authenticateUser()

        XCTAssertFalse(hasCalledDefaultAuth)
        XCTAssertTrue(spyRouter.hasDismissedScreen)
    }

    func test_biometricEnabled_failsToAuth_callsDefault() async {
        settingsService.biometricsEnabled = true
        authService.shouldFailBiometric = true

        await sut.authenticateUser()
        
        XCTAssertTrue(hasCalledDefaultAuth)
    }

    func test_correctPin_dismissGuard() {
        sut.pinAuthentication(passcode: authService.correctPin)

        XCTAssertTrue(spyRouter.hasDismissedScreen)
    }

    func test_wrongPin_failsToAuth() {
        sut.pinAuthentication(passcode: "43434")

        XCTAssertTrue(failedToAuth)
    }

    func test_biometricsDisabled_callsDefaultAuth() async {
        settingsService.biometricsEnabled = false

        await sut.authenticateUser()

        XCTAssertTrue(hasCalledDefaultAuth)
    }

    func setupCallBacks() {
        sut.defaultAuthentication = { [weak self] in
            self?.hasCalledDefaultAuth = true
        }

        sut.failedToAuthenticate = { [weak self] in
            self?.failedToAuth = true
        }
    }

}
