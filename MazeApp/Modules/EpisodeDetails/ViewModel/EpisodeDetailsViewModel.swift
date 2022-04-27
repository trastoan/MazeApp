//
//  EpisodeDetailsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation
protocol EpisodeDetailsViewModelProtocol {
    func buildInfoModel() -> InfoViewModel
    func buildHeaderModel() -> EpisodeHeaderViewModel
}

class EpisodeDetailsViewModel: EpisodeDetailsViewModelProtocol {
    private var router: EpisodeDetailsRouterProtocol
    private var episode: Episode

    init(router: EpisodeDetailsRouterProtocol, episode: Episode) {
        self.router = router
        self.episode = episode
    }

    func buildInfoModel() -> InfoViewModel {
        return InfoViewModel(summary: episode.summary?.removeHTMLTags() ?? "Not available",
                             days: airDateFormatted(episode.airdate),
                             rating: "\(episode.rating?.average ?? 0.0)",
                             time: episode.airtime ?? "")
    }

    func buildHeaderModel() -> EpisodeHeaderViewModel {
        EpisodeHeaderViewModel(poster: URL(string: episode.image?.original ?? ""),
                               title: episode.name,
                               number: String(format: "S%02d | E%02d", episode.season, episode.number))
    }

    private func airDateFormatted(_ unformattedDate: String?) -> String {
        guard let unformatted = unformattedDate else { return "Unknow" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: unformatted) else { return "Unknow" }
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date).capitalized
    }
}
