//
//  Show.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

struct Show: Decodable {
    let id: Int
    let name: String
    let image: Image?
    let genres: [String]
    let summary: String?
    let status: String?
    let schedule: Schedule

    struct Schedule: Decodable {
        let time: String
        let days: [String]
    }
}

struct Image: Decodable {
    let medium: String
    let original: String
}
