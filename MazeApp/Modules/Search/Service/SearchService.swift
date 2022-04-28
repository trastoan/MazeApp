//
//  SearchService.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import MazeNetwork

protocol SearchServiceProtocol {
    func searchFor<T: Decodable>(endpoint: SearchEndpoint) async throws -> [T]
}

class SearchService: SearchServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func searchFor<T>(endpoint: SearchEndpoint) async throws -> [T] where T: Decodable {
        try await client.requestObject(endpoint: endpoint)
    }
}
