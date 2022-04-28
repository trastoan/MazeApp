//
//  SettingsViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

class SettingsViewModelTests: XCTestCase {
    var sut: SettingsViewModel!
    var authSpy: SpyAuthService!
    var settingsService: SettingServices!
    var spyRouter: SpySettingsRouter!


    override func setUp() {
        authSpy = SpyAuthService()
        spyRouter = SpySettingsRouter()
        settingsService = SettingServices()
        settingsService.userDefaults = UserDefaults(suiteName: "TestSuite")!
        sut = SettingsViewModel(settings: settingsService, authService: authSpy)
        sut.router = spyRouter
    }

    override func tearDown() {
        spyRouter = nil
        authSpy = nil
        UserDefaults().removeSuite(named: "TestSuite")
        settingsService = nil
        sut = nil
    }

    func test_changeOnGuardEnabled_savesToSettingsService() {
        sut.guardEnabled = true

        XCTAssertTrue(settingsService.authenticationEnabled)
    }

    func test_changeOnBioEnabled_savesToSettingService() {
        sut.biometricsEnabled = true

        XCTAssertTrue(settingsService.biometricsEnabled)
    }

    func test_initGetsCorrectStates() {
        settingsService.biometricsEnabled = false
        settingsService.authenticationEnabled = false

        let currentSut = SettingsViewModel(settings: settingsService, authService: authSpy)

        XCTAssertNotNil(currentSut.settingService)
        XCTAssertNotNil(currentSut.authenticationService)
        XCTAssertFalse(currentSut.biometricsEnabled)
        XCTAssertFalse(currentSut.guardEnabled)
    }

    func test_whenEnablingBio_ifAuthorized_ChangesSettingService() async throws {
        sut.biometricsEnabled = false
        authSpy.shouldFailBiometric = false

        await sut.changeBiometricStatus()

        XCTAssertTrue(settingsService.biometricsEnabled)
    }

    func test_whenEnablingBio_ifNotAuthorized_changesSettingService() async throws {
        sut.biometricsEnabled = false
        authSpy.shouldFailBiometric = true

        await sut.changeBiometricStatus()

        XCTAssertFalse(settingsService.biometricsEnabled)
    }

    func test_whenDisablingBio_changeSettingsService() async throws {
        sut.biometricsEnabled = true

        await sut.changeBiometricStatus()

        XCTAssertFalse(settingsService.biometricsEnabled)
    }

    func test_uponGuardEnabledChanged_presentPinRegistrationScreen() {
        sut.guardEnabled = true

        XCTAssertTrue(spyRouter.hasCalledRegistration)
    }
}
