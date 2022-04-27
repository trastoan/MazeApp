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

    func buildInfoViewModel() -> ShowInfoViewModel
    func buildHeaderViewModel() -> ShowHeaderViewModel
    func presentEpisodeDetails(_ episode: Episode)
}


class ShowDetailViewModel: ShowDetailViewModelProtocol {
    var router: ShowDetailsRouterProtocol!

    var title: String { show.name }
    private var show: Show
    private let service: ShowDetailServiceProtocol

    @Published private(set) var isLoading = true
    private(set) var backgroundImage: URL? = nil
    private(set) var seasons: [Season] = []
    private(set) var episodes: [Episode] = []
    private(set) var cast: [Cast] = []
    private(set) var crew: [Crew] = []

    init(show: Show, service: ShowDetailServiceProtocol = ShowDetailService()) {
        self.show = show
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


    private func loadCastInfo() async throws {
        cast = try await service.listCast(showId: show.id)
    }


    private func loadCrewInfo() async throws {
        crew = try await service.listCrew(showId: show.id)
    }

    @MainActor
    private func loadInfo() async throws {
        isLoading = true
        await withThrowingTaskGroup(of: Void.self, body: { group in
            group.addTask { try await self.loadBackgroundImage() }
            group.addTask { try await self.loadEpisodesInfo() }
            group.addTask { try await self.loadCastInfo() }
            group.addTask { try await self.loadCrewInfo() }
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

    func buildInfoViewModel() -> ShowInfoViewModel {
        return ShowInfoViewModel(summary: show.summary?.removeHTMLTags() ?? "None Available",
                                          days: show.schedule.days.reduce("", { $0 + " | " + $1.prefix(3)}),
                                          rating: "\(show.rating?.average ?? 0)",
                                          time: show.schedule.time)
    }

    func buildHeaderViewModel() -> ShowHeaderViewModel {
        return ShowHeaderViewModel(posterImage: URL(string: show.image?.medium ?? ""),
                                              backgroundImage: backgroundImage,
                                              status: show.status ?? "Unknow",
                                              numberOfSeasons: seasons.count,
                                              network: show.network?.name ?? "Unknow",
                                              genres: show.genres.prefix(3).joined(separator: " | "))
    }

    func presentEpisodeDetails(_ episode: Episode) {
        router.presentEpisodeDetails(for: episode)
    }
}