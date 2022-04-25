//
//  SearchEndpoint.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation
import MazeNetwork

enum SearchEndpoint: ServiceEndpoint {
    case show(named: String), people(named: String)

    var path: String {
        switch self {
            case .show:
                return "/search/shows"
            case .people:
                return "/search/people"
        }
    }

    var baseUrl: String { "https://api.tvmaze.com" }

    var queryParameters: [String : String]? {
        switch self {
            case .show(let name):
                return ["q": "\(name)"]
            case .people(let name):
                return ["q": "\(name)"]
        }
    }

    var method: HttpMethod { .get }
    
}
