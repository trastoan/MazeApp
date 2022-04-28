//
//  MockRouteTests.swift
//  
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeNetwork

struct MockItem: Codable {
    var testString: String

    static func mockedData() -> Data? {
        let item = MockItem(testString: "Test")
        let data = try? JSONEncoder().encode(item)
        return data
    }
}

enum MockRoute: ServiceEndpoint {

    case goodRoute
    case goodRouteWithQueryParameters
    case throwableRoute

    var path: String {
        switch self {
            case .goodRoute, .goodRouteWithQueryParameters:
                return "/path"
            case .throwableRoute:
                return "//path"
        }
    }
    var baseUrl: String {
        switch self {
            case .goodRoute, .goodRouteWithQueryParameters:
                return "https://test.endpoint.com"
            case .throwableRoute:
                return ""
        }
    }

    var queryParameters: [String: String]? {
        switch self {
            case .goodRouteWithQueryParameters:
                return ["q": "query"]
            case .throwableRoute, .goodRoute:
                return nil
        }
    }

    var method: HttpMethod { .get }
}

class Mocker {
    var testData: Data?
    var testError: Error?
    var lastURL: URL?
    var url: URL
    var statusCode: Int
    var calledResume = false

    init(url: URL = URL(string: "https://fakeURL.com")!, statusCode: Int) {
        self.url = url
        self.statusCode = statusCode
    }
}

class URLProtocolMock: URLProtocol {
    static var mock: Mocker?

    override class func canInit(with request: URLRequest) -> Bool {
        URLProtocolMock.mock?.lastURL = request.url
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let mock = URLProtocolMock.mock else { fatalError("Needs to define mock") }
        mock.calledResume = true

        let response = HTTPURLResponse(url: mock.url, statusCode: mock.statusCode, httpVersion: nil, headerFields: nil)!
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowedInMemoryOnly)
        self.client?.urlProtocol(self, didLoad: URLProtocolMock.mock?.testData ?? Data())
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    static func clearMockData() {
        URLProtocolMock.mock = nil
    }
}
