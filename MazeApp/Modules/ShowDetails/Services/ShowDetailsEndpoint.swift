//
//  ShowDetailsEndpoint.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import MazeNetwork

enum ShowDetailsEndpoint: ServiceEndpoint {
    case seasons(showId: Int)
    case episodes(showId: Int)
    case images(showId: Int)
    case cast(showId: Int)
    case crew(showId: Int)

    var path: String {
        switch self {
            case .seasons(let id):
                return "/shows/\(id)/seasons"
            case .episodes(let id):
                return "/shows/\(id)/episodes"
            case .images(let id):
                return "/shows/\(id)/images"
            case .cast(let id):
                return "/shows/\(id)/cast"
            case .crew(let id):
                return "/shows/\(id)/crew"
        }
    }

    var baseUrl: String { "https://api.tvmaze.com" }

    var queryParameters: [String : String]? { nil }

    var method: HttpMethod { .get }


}
