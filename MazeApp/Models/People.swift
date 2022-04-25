//
//  People.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

struct PeopleSearch: Decodable {
    var score: Double
    var person: People
}

struct People: Decodable {
    var id: Int
    var url: String
    var name: String
    var country: Country?
    var image: Image?

    struct Country: Decodable {
        var name: String
        var code: String
    }

}
