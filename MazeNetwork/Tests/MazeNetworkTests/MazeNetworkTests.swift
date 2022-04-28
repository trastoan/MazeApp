import XCTest
@testable import MazeNetwork

class MazeNetworkTests: XCTestCase {
    var sut: HTTPWorker!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)

        sut = HTTPWorker(session: mockSession)
    }

    func test_should_decode() async throws {
        let mocker = Mocker(statusCode: 200)
        guard let testData = MockItem.mockedData() else {
            XCTFail("Should have valid data")
            return
        }
        mocker.testData = testData
        URLProtocolMock.mock = mocker

        let decoded: MockItem = try await sut.requestObject(endpoint: MockRoute.goodRoute)

        XCTAssertEqual(decoded.testString, "Test")
    }

    func test_invalidDataShould_throwDecode() async {
        let mocker = Mocker(statusCode: 200)
        mocker.testData = "1234".data(using: .utf8)
        URLProtocolMock.mock = mocker

        do {
            let _: MockItem = try await sut.requestObject(endpoint: MockRoute.goodRoute)
        } catch {
            guard let clientError = error as? HTTPClientError else {
                XCTFail("It should be a HTTPClientError")
                return
            }
            XCTAssertNotNil(clientError)
            XCTAssertEqual(clientError, .invalidObject)
        }
    }

    func test_url_shouldThrow_urlCreation() {
        do {
            _ = try sut.url(from: MockRoute.throwableRoute)
            XCTFail("It should throw")
        } catch {
            guard let clientError = error as? HTTPClientError else {
                XCTFail("It should be a HTTPClientError")
                return
            }
            XCTAssertNotNil(clientError)
            XCTAssertEqual(clientError, .urlCreation)
        }
    }

    func test_url_shouldWork() {
        do {
            let url = try sut.url(from: MockRoute.goodRoute)
            let expectedUrl = "https://test.endpoint.com/path"
            XCTAssertEqual(expectedUrl, url.absoluteString)
        } catch {
            XCTFail("It should not fail")
        }
    }

    func test_url_shouldWork_withQueryParameters() {
        do {
            let url = try sut.url(from: MockRoute.goodRouteWithQueryParameters)
            let expectedUrl = "https://test.endpoint.com/path?q=query"
            XCTAssertEqual(expectedUrl, url.absoluteString)
        } catch {
            XCTFail("It should not fail")
        }
    }
}
