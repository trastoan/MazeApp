//
//  Episodes.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct Episode: Decodable, Identifiable {
    var id: Int
    var name: String
    var season: Int
    var number: Int
    var airdate: String?
    var airtime: String?
    var image: MazeImage?
    var summary: String?
    var rating: Rating?

}
