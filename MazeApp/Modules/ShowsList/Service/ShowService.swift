//
//  ShowService.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import MazeNetwork

protocol ShowServiceProtocol {
    func listShows(page: Int) async throws -> [Show]
}

class ShowService: ShowServiceProtocol {

    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func listShows(page: Int) async throws -> [Show] {
        try await client.requestObject(endpoint: ShowEndpoint.shows(page: page))
    }
}
