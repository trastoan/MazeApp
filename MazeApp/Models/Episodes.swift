//
//  Episodes.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct Episode: Decodable {
    var id: Int
    var name: String
    var season: Int
    var number: Int
    var image: MazeImage?
    var summary: String?
}
