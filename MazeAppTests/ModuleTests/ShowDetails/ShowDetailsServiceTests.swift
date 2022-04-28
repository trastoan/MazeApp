//
//  ShowDetailsServiceTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

@testable import MazeApp
import MazeNetwork
import XCTest

class ShowDetailsServiceTests: XCTestCase {
    var sut: ShowDetailService!
    var mockClient: HTTPClient!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)

        mockClient = HTTPWorker(session: mockSession)
        sut = ShowDetailService(client: mockClient)
    }

    override func tearDown() {
        mockClient = nil
        sut = nil
    }

    func test_sessionListImages_returnsEmpty() async throws {
        let mockData = "[]".data(using: .utf8)
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let images = try await sut.listImages(showId: 0)

        XCTAssertTrue(images.isEmpty)
    }

    func test_sessionListImages_returnsThree() async throws {
        let mockData = JSONLoader().loadData(named: "Images")
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let images = try await sut.listImages(showId: 0)

        XCTAssertEqual(images.count, 3)
    }

    func test_sessionListImages_throwsError() async {
        let mockData = Data()
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        do {
            let _ = try await sut.listImages(showId: 0)
            XCTFail("Should throws")
        } catch(let error) {
            guard let castedError = error as? HTTPClientError else {
                XCTFail("Should be an HTTPClientError")
                return
            }
            XCTAssertEqual(castedError, .invalidObject)
        }
    }


    func test_sessionListEpisodes_returnsEmpty() async throws {
        let mockData = "[]".data(using: .utf8)
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let episodes = try await sut.listEpisodes(showId: 0)

        XCTAssertTrue(episodes.isEmpty)
    }

    func test_sessionListEpisodes_returnsThree() async throws {
        let mockData = JSONLoader().loadData(named: "Episodes")
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        let episodes = try await sut.listEpisodes(showId: 0)

        XCTAssertEqual(episodes.count, 4)
    }

    func test_sessionListEpisodes_throwsError() async {
        let mockData = Data()
        let mocker = Mocker(statusCode: 200)
        mocker.testData = mockData
        URLProtocolMock.mock = mocker

        do {
            let _ = try await sut.listEpisodes(showId: 0)
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

