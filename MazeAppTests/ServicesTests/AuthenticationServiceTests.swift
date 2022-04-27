//
//  AuthenticationServiceTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation

import XCTest
@testable import MazeApp

struct UnsupportedData {
    var test: String
}

class AuthenticationServiceTests: XCTestCase {
    var sut: AuthenticationService!
    let service = "TestService"

    override func setUpWithError() throws {
        sut = AuthenticationService()
    }

    override func tearDownWithError() throws {
        sut = nil
        _ = KeychainService().delete(service: service)
    }

    func test_savePin_itsStoredOnKeychain() {
        if !sut.savePin("123456", service: service) {
            XCTFail()
        }
        XCTAssertTrue(sut.pinAuthentication("123456", service: service))
    }

    func test_wrongPin_returnsFalseAuth() {
        if !sut.savePin("123456", service: service) {
            XCTFail()
        }
        XCTAssertFalse(sut.pinAuthentication("1456", service: service))
    }

    func test_noRegisteredPin_failsToAuthenticate() {
        XCTAssertFalse(sut.pinAuthentication("123456", service: service))
    }
}
