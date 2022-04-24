//
//  ServiceRoute.swift
//  
//
//  Created by Yuri on 24/04/22.
//

import Foundation

public protocol ServiceEndpoint {
    var path: String { get }
    var baseUrl: String { get }
    var queryParameters: [String: String]? { get }
    var method: HttpMethod { get }
}

public enum HttpMethod: String {
    case get, post

    public var value: String { rawValue.uppercased() }
}
