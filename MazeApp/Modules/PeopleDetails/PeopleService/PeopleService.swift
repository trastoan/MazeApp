//
//  PeopleService.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import MazeNetwork

protocol PeopleDetailServiceProtocol {
    func listCastCredits(_ id: Int) async throws -> [CastCredits]
    func listCrewCredits(_ id: Int) async throws -> [CrewCredits]
}

class PeopleDetailService: PeopleDetailServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func listCastCredits(_ id: Int) async throws -> [CastCredits] {
        try await client.requestObject(endpoint: PeopleDetailEndpoint.relatedShowsAsCast(peopleId: id))
    }

    func listCrewCredits(_ id: Int) async throws -> [CrewCredits] {
        try await client.requestObject(endpoint: PeopleDetailEndpoint.relatedShowAsCrew(peopleId: id))
    }
    
}
