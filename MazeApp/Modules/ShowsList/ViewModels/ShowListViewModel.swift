//
//  ShowListViewModel.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

protocol ShowListModel {
    var router: ShowListRouterProtocol! { get }
    var title: String { get }
    var numberofShows: Int { get }

    var hasFinishedFetch: (() -> ())? { get set }
    var insertNewShows: (([IndexPath]) -> ())? { get set }

    func fetch() async throws
    func fetchNextPage() async throws
    func show(for index: Int) -> Show
}

class ShowListViewModel: ShowListModel {

    private let service: ShowServiceProtocol
    private var shows: [Show] = []
    private var currentPage = 0
    private var hasReachEnd = false

    var router: ShowListRouterProtocol!
    var title: String { "Shows List" }
    var numberofShows: Int { shows.count }

    var hasFinishedFetch: (() -> ())?
    var insertNewShows: (([IndexPath]) -> ())?

    init(service: ShowServiceProtocol = ShowService()) {
        self.service = service
    }

    private func fetchShows() async throws -> [Show] {
        try await service.listShows(page: currentPage)
    }

    @MainActor
    func fetch() async throws {
        shows = try await fetchShows()
        hasFinishedFetch?()
        //call delegate
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
}
