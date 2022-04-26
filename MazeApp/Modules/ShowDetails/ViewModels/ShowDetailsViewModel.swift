//
//  ShowDetailsViewModel.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

protocol ShowDetailViewModelProtocol: ObservableObject {
    var title: String { get }
    var isLoading: Bool { get }
    var backgroundImage: URL? { get }
    var posterImage: URL? { get }
}


class ShowDetailViewModel: ShowDetailViewModelProtocol {
    var router: ShowDetailsRouterProtocol!
    private var show: Show
    private let service: ShowDetailServiceProtocol

    var title: String { show.name }

    @Published private(set) var isLoading = true
    private(set) var backgroundImage: URL? = nil
    private(set) var seasons: [Season] = []
    private(set) var episodes: [Episode] = []
    private(set) var cast: [Cast] = []
    private(set) var crew: [Crew] = []

    var posterImage: URL? { URL(string: show.image?.medium ?? "") }

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
        isLoading = false
    }
}
