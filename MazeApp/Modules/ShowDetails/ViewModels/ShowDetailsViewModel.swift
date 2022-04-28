//
//  ShowDetailsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

protocol ShowDetailViewModelProtocol: ObservableObject {

    var isLoading: Bool { get }
    var backgroundImage: URL? { get }
    var title: String { get }
    var seasons: [Season] { get }

    func buildInfoViewModel() -> InfoViewModel
    func buildHeaderViewModel() -> ShowHeaderViewModel
    func presentEpisodeDetails(_ episode: Episode)
}

class ShowDetailViewModel: ShowDetailViewModelProtocol {
    var router: ShowDetailsRouterProtocol

    var title: String { show.name }
    private var show: Show
    private let service: ShowDetailServiceProtocol

    @Published var isLoading = true
    private(set) var backgroundImage: URL?
    private(set) var seasons: [Season] = []
    private(set) var episodes: [Episode] = []
    private(set) var cast: [Cast] = []
    private(set) var crew: [Crew] = []

    init(show: Show, service: ShowDetailServiceProtocol = ShowDetailService(), router: ShowDetailsRouterProtocol = ShowDetailsRouter()) {
        self.show = show
        self.router = router
        self.service = service
        Task {
            try await loadInfo()
        }
    }

    private func loadBackgroundImage() async throws {
        let images = try await service.listImages(showId: show.id)
        let background = images.first(where: { $0.type == "background" })
        backgroundImage = URL(string: background?.originalURL ?? "")
    }

    private func loadEpisodesInfo() async throws {
        episodes = try await service.listEpisodes(showId: show.id)
    }

    @MainActor
    func loadInfo() async throws {
        isLoading = true
        await withThrowingTaskGroup(of: Void.self, body: { group in
            group.addTask { try await self.loadBackgroundImage() }
            group.addTask { try await self.loadEpisodesInfo() }
        })
        seasons = buildSeasons(episodes: episodes)
        isLoading = false
    }

    private func buildSeasons(episodes: [Episode]) -> [Season] {
        let season: [Season] = episodes.reduce([]) { partialResult, episode in
            var newResult = partialResult
            if newResult.isEmpty {
                let season = Season(number: episode.season, episodes: [episode])
                newResult.append(season)
            } else {
                if let index = newResult.firstIndex(where: { season in season.number == episode.season }) {
                    newResult[index].episodes.append(episode)
                } else {
                    let season = Season(number: episode.season, episodes: [episode])
                    newResult.append(season)
                }
            }
            return newResult
        }
        return season
    }

    func buildInfoViewModel() -> InfoViewModel {
        return InfoViewModel(summary: show.summary?.removeHTMLTags() ?? "None Available",
                                          days: formatShowDays(),
                                          rating: formatRating(),
                                          time: show.schedule?.time ?? "")
    }

    func buildHeaderViewModel() -> ShowHeaderViewModel {
        return ShowHeaderViewModel(posterImage: URL(string: show.image?.medium ?? ""),
                                              backgroundImage: backgroundImage,
                                              status: show.status ?? "Unknow",
                                              numberOfSeasons: seasons.count,
                                              network: show.network?.name ?? "Unknow",
                                              genres: show.genres.prefix(3).joined(separator: " | "))
    }

    func formatRating() -> String {
        guard let rating = show.rating?.average else { return "Not Rated"}
        return "\(rating)"
    }
    func formatShowDays() -> String {
        guard let days = show.schedule?.days else { return "" }
        return days.reduce("", { $0 + " | " + $1.prefix(3)})
    }

    func presentEpisodeDetails(_ episode: Episode) {
        router.presentEpisodeDetails(for: episode)
    }
}
