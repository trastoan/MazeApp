//
//  ShowRoute.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation
import MazeNetwork

enum ShowEndpoint: ServiceEndpoint {
    case shows(page: Int)

    var path: String {
        switch self {
            case .shows:
                return "/shows"
        }
    }

    var baseUrl: String { "https://api.tvmaze.com" }

    var queryParameters: [String : String]? {
        switch self {
            case .shows(page: let page):
                return ["page": "\(page)"]
        }
    }

    var method: HttpMethod { .get }

}
