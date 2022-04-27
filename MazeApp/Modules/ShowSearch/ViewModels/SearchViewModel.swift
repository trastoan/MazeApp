//
//  SearchViewModel.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation

enum SearchType: String {
    case people
    case show
}

protocol SearchViewModelProtocol {
    var router: SearchRouter! { get }
    var numberOfResults: Int { get }
    var searchTypes: [SearchType] { get }
    var title: String { get }

    var hasFinishedSearching: (() -> Void)? { get set }

    func resetSearch()
    func changeSearch(index: Int)
    func search(for: String) async throws
    func showDetails(for row: Int)
    func model(for row: Int) -> SearchTableCellModel?
}

class SearchViewModel: SearchViewModelProtocol {
    private var results: [SearchTableCellModel] = []
    private var service: SearchServiceProtocol
    private var currentSearchType: SearchType = .show
    private var lastShows: [Show] = []
    private var lastPeople: [People] = []

    var router: SearchRouter!
    var title: String { return "Search"}
    var numberOfResults: Int { results.count }
    var searchTypes: [SearchType] { [.show, .people]}

    var hasFinishedSearching: (() -> Void)?

    init(with service: SearchServiceProtocol = SearchService()) {
        self.service = service
    }

    func resetSearch() {
        results = []
        hasFinishedSearching?()
    }

    func changeSearch(index: Int) {
        let type = searchTypes[index]
        currentSearchType = type
    }

    @MainActor
    func search(for name: String) async throws {
        results = []
        switch currentSearchType {
            case .people:
                let searchResult: [PeopleSearch] = try await service.searchFor(endpoint: .people(named: name))
                try Task.checkCancellation()
                lastPeople = searchResult.map { $0.person }
                results = searchResult.map { SearchTableCellModel(with: $0.person) }
            case .show:
                let searchResult: [ShowSearch] = try await service.searchFor(endpoint: .show(named: name))
                try Task.checkCancellation()
                lastShows = searchResult.map { $0.show }
                results = searchResult.map { SearchTableCellModel(with: $0.show) }
        }
        hasFinishedSearching?()
    }

    func showDetails(for row: Int) {
        switch currentSearchType {
            case .people:
                router.presentDetailsForPeople(lastPeople[row])
                return
            case .show:
                router.presentDetailsForShow(lastShows[row])
                return
        }
    }

    func model(for row: Int) -> SearchTableCellModel? {
        if row < results.count {
            return results[row]
        }
        return nil
    }

}
