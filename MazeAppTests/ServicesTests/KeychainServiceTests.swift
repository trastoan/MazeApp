//
//  KeychainServiceTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

enum TestErrors: Error {
    case unexpectedError
}

class KeychainServiceTests: XCTestCase {
    var sut: KeychainService!
    var service = "testService"

    override func setUpWithError() throws {
        sut = KeychainService()
    }

    override func tearDownWithError() throws {
        _ = sut.delete(service: service)
        sut = nil
    }

    func test_savingToKeychain_toBeSuccessfull() throws {
        let savedData = try saveData(code: "123456")

        let retrievedData = sut.read(service: service)
        XCTAssertEqual(savedData, retrievedData)
    }

    func test_updatingToKeychain_toBeSuccessfull() throws {
        _ = try saveData(code: "123456")
        guard let dataToBeUpdated = "7890".data(using: .utf8) else { throw TestErrors.unexpectedError}
        _ = sut.update(data: dataToBeUpdated, service: service)
        let retrievedData = sut.read(service: service)

        XCTAssertEqual(dataToBeUpdated, retrievedData)
    }

    private func saveData(code: String) throws -> Data {
        guard let data = code.data(using: .utf8) else { throw TestErrors.unexpectedError }
        if !sut.save(data, service: service) {
            XCTFail()
        }
        return data
    }

    func test_duplicatingItem_updatesOldValue() throws {
        _ = try saveData(code: "123456")
        let newValue = "7890"
        let newValueData = try saveData(code: newValue)
        let retrievedData = sut.read(service: service)

        XCTAssertEqual(newValueData, retrievedData)
    }
}
