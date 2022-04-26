//
//  ShowDetailsService.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import MazeNetwork

protocol ShowDetailServiceProtocol {
    func listImages(showId: Int) async throws -> [ShowImage]
    func listEpisodes(showId: Int) async throws -> [Episode]
    func listCrew(showId: Int) async throws -> [Crew]
    func listCast(showId: Int) async throws -> [Cast]
}

class ShowDetailService:  ShowDetailServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func listImages(showId: Int) async throws -> [ShowImage] {
        try await client.requestObject(endpoint: ShowDetailsEndpoint.images(showId: showId))
    }

    func listEpisodes(showId: Int) async throws -> [Episode] {
        try await client.requestObject(endpoint: ShowDetailsEndpoint.episodes(showId: showId))
    }

    func listCrew(showId: Int) async throws -> [Crew] {
        try await client.requestObject(endpoint: ShowDetailsEndpoint.crew(showId: showId))
    }

    func listCast(showId: Int) async throws -> [Cast] {
        try await client.requestObject(endpoint: ShowDetailsEndpoint.cast(showId: showId))
    }
}
