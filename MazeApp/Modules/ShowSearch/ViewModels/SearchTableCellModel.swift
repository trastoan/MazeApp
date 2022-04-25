//
//  SearchTableCellModel.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

struct SearchTableCellModel {
    var name: String
    var subtitle: String
    var image: String?

    init(with show: Show) {
        self.name = show.name
        self.subtitle = show.genres.joined(separator: " ")
        self.image = show.image?.medium
    }

    init(with people: People) {
        self.name = people.name
        self.subtitle = people.country ?? "Unknow"
        self.image = people.image?.medium
    }
}
