//
//  EpisodeHeaderViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

class EpisodeHeaderViewModel {
    var poster: URL?
    var title: String
    var number: String

    init(poster: URL?, title: String, number: String) {
        self.poster = poster
        self.title = title
        self.number = number
    }
}
