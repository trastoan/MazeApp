//
//  Show.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

struct ShowSearch: Decodable {
    var score: Double
    var show: Show
}

struct Show: Decodable, Hashable {

    let id: Int
    let name: String
    let image: MazeImage?
    let genres: [String]
    let summary: String?
    let status: String?
    let schedule: Schedule?
    var rating: Rating?
    let network: Network?

    struct Schedule: Decodable {
        let time: String?
        let days: [String]?
    }

    struct Network: Decodable {
        var id: Int
        var name: String
    }

    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == lhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
