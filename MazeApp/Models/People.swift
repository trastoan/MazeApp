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
    var image: MazeImage?
    var birthday: String?
    var age: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let birthDate = formatter.date(from: birthday ?? "") else { return nil }
        return birthDate.yearsBetweenDate(endDate: Date())
    }

    struct Country: Decodable {
        var name: String
        var code: String
    }
}
