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

}

struct Character: Decodable {
    var id: Int
    var name: String
    var image: MazeImage?
}

struct CastCredits: Decodable {
    var embedded: EmbeddedContent

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
    
}

struct EmbeddedContent: Decodable {
    var show: Show?
    var character: Character?
}
