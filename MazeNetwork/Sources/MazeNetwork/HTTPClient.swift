//
//  HTTPClient.swift
//  
//
//  Created by Yuri on 24/04/22.
//

import Foundation
import UIKit

public protocol HTTPClient {
    func requestObject<Model: Decodable>(endpoint: ServiceEndpoint) async throws -> Model
}

public enum HTTPClientError: Error, Equatable {
    case urlCreation
}

public struct HTTPWorker: HTTPClient {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func requestObject<Model>(endpoint: ServiceEndpoint) async throws -> Model where Model : Decodable {
        let url = try url(from: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.value
        let (data, _) = try await session.data(from: url)

        return try JSONDecoder().decode(Model.self, from: data)
    }

    func url(from endpoint: ServiceEndpoint) throws -> URL {
        var urlComponent = URLComponents(string: endpoint.baseUrl)
        urlComponent?.path = endpoint.path
        urlComponent?.queryItems = endpoint.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponent?.url else {
            throw HTTPClientError.urlCreation
        }
        return url
    }
}
