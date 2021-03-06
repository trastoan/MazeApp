//
//  ShowListViewModel.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

protocol ShowListModel {
    var router: ShowListRouterProtocol { get }
    var title: String { get }
    var numberofShows: Int { get }

    var hasFinishedFetch: (() -> Void)? { get set }
    var insertNewShows: (([IndexPath]) -> Void)? { get set }

    func fetch() async throws
    func fetchNextPage() async throws
    func show(for index: Int) -> Show
    func showDetails(for index: Int)
    func showConfigurations()
}

class ShowListViewModel: ShowListModel {

    private let service: ShowServiceProtocol
    private var shows: [Show] = []
    private var hasReachEnd = false
    var currentPage = 0

    var router: ShowListRouterProtocol
    var title: String { "Discover" }
    var numberofShows: Int { shows.count }

    var hasFinishedFetch: (() -> Void)?
    var insertNewShows: (([IndexPath]) -> Void)?

    init(service: ShowServiceProtocol = ShowService(), router: ShowListRouterProtocol) {
        self.service = service
        self.router = router
    }

    private func fetchShows() async throws -> [Show] {
        try await service.listShows(page: currentPage)
    }

    @MainActor
    func fetch() async throws {
        shows = try await fetchShows()
        hasFinishedFetch?()
    }

    @MainActor
    func fetchNextPage() async throws {
        if !hasReachEnd {
            currentPage += 1
            let newShows = try await service.listShows(page: currentPage)
            hasReachEnd = newShows.isEmpty
            shows += newShows
            let indexes = buildNewIndexes(from: newShows.count)
            insertNewShows?(indexes)
        }
    }

    func buildNewIndexes(from newCount: Int) -> [IndexPath] {
        let startIndex = shows.count - newCount
        let endIndex = shows.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    func show(for index: Int) -> Show { shows[index] }

    func showDetails(for index: Int) {
        let show = shows[index]
        router.presentDetailsForShow(show)
    }

    func showConfigurations() {
        router.presentConfigurations()
    }
}
