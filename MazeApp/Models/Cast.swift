//
//  Cast.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

struct Cast: Decodable {
    var person: People
    var character: Character?

    struct Character: Decodable {
        var id: Int
        var name: String
        var image: MazeImage?
    }
}
