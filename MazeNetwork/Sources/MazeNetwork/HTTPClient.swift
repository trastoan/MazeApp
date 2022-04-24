//
//  HTTPClient.swift
//  
//
//  Created by Yuri on 24/04/22.
//

import Foundation
import UIKit

public protocol HTTPClient {
    func requestObject<Model: Decodable>(route: ServiceRoute) async throws -> Model
}

public enum HTTPClientError: Error, Equatable {
    case urlCreation
}

public struct HTTPWorker: HTTPClient {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func requestObject<Model>(route: ServiceRoute) async throws -> Model where Model : Decodable {
        let url = try url(from: route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method.value
        let (data, _) = try await session.data(from: url)

        return try JSONDecoder().decode(Model.self, from: data)
    }

    func url(from route: ServiceRoute) throws -> URL {
        var urlComponent = URLComponents(string: route.baseUrl)
        urlComponent?.path = route.path
        urlComponent?.queryItems = route.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponent?.url else {
            throw HTTPClientError.urlCreation
        }
        return url
    }
}
