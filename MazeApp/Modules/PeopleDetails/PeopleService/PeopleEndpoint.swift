//
//  PeopleEndpoint.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import MazeNetwork

enum PeopleDetailEndpoint: ServiceEndpoint {
    case relatedShowsAsCast(peopleId: Int)
    case relatedShowAsCrew(peopleId: Int)

    var path: String {
        switch self {
            case .relatedShowsAsCast(let id):
                return "/people/\(id)/castcredits"
            case .relatedShowAsCrew(let id):
                return "/people/\(id)/crewcredits"
        }
    }

    var baseUrl: String { "https://api.tvmaze.com" }

    var queryParameters: [String: String]? {
        switch self {
            case .relatedShowsAsCast, .relatedShowAsCrew:
                return ["embed": "show"]
        }
    }

    var method: HttpMethod { .get }
}
