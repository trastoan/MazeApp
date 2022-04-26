//
//  Seasons.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct Season: Identifiable {
    var id: Int { return number }
    var number: Int
    var episodes: [Episode]
}
