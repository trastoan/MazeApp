//
//  Seasons.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct Season: Decodable {
    var id: Int
    var number: Int
    var numberOfEpisodes: Int?

    enum CodingKeys: String, CodingKey {
        case id, number
        case numberOfEpisodes = "episodeOrder"
    }
}
