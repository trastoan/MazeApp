//
//  PeopleDetailViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

protocol PeopleViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var shows: [Show] { get }
    var poster: URL? { get }
    var name: String { get }
    func presentShowDetail(show: Show)
}

class PeopleViewModel: PeopleViewModelProtocol {
    var router: PeopleDetailRouterProtocol
    private var people: People
    private var service: PeopleDetailServiceProtocol

    private (set) var shows: [Show] = []
    var poster: URL? { URL(string: people.image?.medium ?? "")}
    var name: String { people.name }
    @Published private (set) var isLoading = true


    init(router: PeopleDetailRouterProtocol, people: People, service: PeopleDetailServiceProtocol = PeopleDetailService()) {
        self.router = router
        self.people = people
        self.service = service
        Task {
            try await loadRelatedInfo()
        }
    }

    @MainActor
    func loadRelatedInfo() async throws {
        isLoading = true
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await self.loadShowsAsCast() }
            group.addTask { try await self.loadShowsAsCrew() }
        }
        shows = shows.unique()
        isLoading = false
    }

    func loadShowsAsCast() async throws {
        let castCredits = try await service.listCastCredits(people.id)
        shows.append(contentsOf: castCredits.compactMap { $0.embedded.show })
    }

    func loadShowsAsCrew() async throws {
        let crewCredits = try await service.listCrewCredits(people.id)
        shows.append(contentsOf: crewCredits.compactMap { $0.embedded.show })
    }

    func presentShowDetail(show: Show) {
        router.presentShowDetails(show: show)
    }

}
