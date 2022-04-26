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

    var infoViewModel: ShowInfoViewModel! { get }
    var headerViewModel: ShowHeaderViewModel! { get }
}


class ShowDetailViewModel: ShowDetailViewModelProtocol {
    var router: ShowDetailsRouterProtocol!

    var title: String { show.name }
    private var show: Show
    private let service: ShowDetailServiceProtocol

    private (set) var infoViewModel: ShowInfoViewModel!
    private (set) var headerViewModel: ShowHeaderViewModel!

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


    func loadBackgroundImage() async throws {
        let images = try await service.listImages(showId: show.id)
        let background = images.first(where: { $0.type == "background" })
        backgroundImage = URL(string: background?.originalURL ?? "")
    }


    private func loadSeasonsInfo() async throws {
        seasons = try await service.listSeasons(showId: show.id)
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
            group.addTask { try await self.loadSeasonsInfo() }
            group.addTask { try await self.loadEpisodesInfo() }
            group.addTask { try await self.loadCastInfo() }
            group.addTask { try await self.loadCrewInfo() }
        })
        buildInfoViewModel()
        buildHeaderViewModel()
        isLoading = false
    }

    func buildInfoViewModel() {
        infoViewModel = ShowInfoViewModel(summary: show.summary?.removeHTMLTags() ?? "None Available",
                                          days: show.schedule.days.reduce("", { $0 + " | " + $1.prefix(3)}),
                                          rating: "\(show.rating?.average ?? 0) ",
                                          time: show.schedule.time)
    }

    func buildHeaderViewModel() {
        headerViewModel = ShowHeaderViewModel(posterImage: URL(string: show.image?.medium ?? ""),
                                              backgroundImage: backgroundImage,
                                              status: show.status ?? "Unknow",
                                              numberOfSeasons: seasons.count,
                                              network: show.network?.name ?? "Unknow",
                                              genres: show.genres.prefix(3).joined(separator: " | "))
    }
}
