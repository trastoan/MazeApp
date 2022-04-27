//
//  Crew.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct Crew: Decodable {
    var role: String
    var person: People

    enum CodingKeys: String, CodingKey {
        case role = "type"
        case person
    }
}

struct CrewCredits: Decodable {
    var type: String
    var embedded: EmbeddedContent

    enum CodingKeys: String, CodingKey {
        case type
        case embedded = "_embedded"
    }
}
