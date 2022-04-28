//
//  SearchServicesTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import XCTest
import MazeNetwork
@testable import MazeApp

class SearchServiceTests: XCTestCase {
    var sut: SearchService!
    var mockClient: HTTPClient!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)

        mockClient = HTTPWorker(session: mockSession)
        sut = SearchService(client: mockClient)
    }

    override func tearDown() {
        mockClient = nil
        sut = nil
    }


    func test_sessionSearchPeople_returnsEmpty() async throws {
        let mockData = "[]".data(using: .utf8)
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let people: [PeopleSearch] = try await sut.searchFor(endpoint: .people(named: ""))

        XCTAssertTrue(people.isEmpty)
    }

    func test_sessionSearchPeople_returnsFour() async throws {
        let mockData = JSONLoader().loadData(named: "PeopleSearch")
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let people: [PeopleSearch] = try await sut.searchFor(endpoint: .people(named: ""))

        XCTAssertEqual(people.count, 4)
    }

    func test_sessionSearchPeople_throwsError() async {
        let mockData = Data()
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        do {
            let _: [PeopleSearch] = try await sut.searchFor(endpoint: .people(named: ""))
            XCTFail("Should throws")
        } catch(let error) {
            guard let castedError = error as? HTTPClientError else {
                XCTFail("Should be an HTTPClientError")
                return
            }
            XCTAssertEqual(castedError, .invalidObject)
        }
    }

}
