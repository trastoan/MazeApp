//
//  ShowHeaderViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

class ShowHeaderViewModel {

    var posterImage: URL?
    private(set) var backgroundImage: URL?
    var status: String
    var numberOfSeasons: Int
    var network: String
    var genres: String

    init(posterImage: URL?, backgroundImage: URL?, status: String, numberOfSeasons: Int, network: String, genres: String ){
        self.posterImage = posterImage
        self.backgroundImage = backgroundImage
        self.status = status
        self.numberOfSeasons = numberOfSeasons
        self.network = network
        self.genres = genres
    }
}
