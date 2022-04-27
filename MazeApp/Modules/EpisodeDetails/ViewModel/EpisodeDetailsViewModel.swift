//
//  EpisodeDetailsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation
protocol EpisodeDetailsViewModelProtocol {

}

class EpisodeDetailsViewModel: EpisodeDetailsViewModelProtocol {
    private var router: EpisodeDetailsRouterProtocol
    private var episode: Episode

    init(router: EpisodeDetailsRouterProtocol, episode: Episode) {
        self.router = router
        self.episode = episode
    }
}
