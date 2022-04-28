//
//  SearchViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import XCTest
@testable import MazeApp

class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var spyRouter: SearchRouterSpy!
    var mockService: SearchServiceMock!

    override func setUp() {
        spyRouter = SearchRouterSpy()
        mockService = SearchServiceMock()
        sut = SearchViewModel(with: mockService, router: spyRouter)
    }

    override func tearDown() async throws {
        sut = nil
        mockService = nil
        spyRouter = nil
    }

    func test_searchForPeople_shouldReturnFour() async throws {
        sut.changeSearch(index: 1)
        try await sut.search(for: "teste")
        XCTAssertEqual(sut.numberOfResults, 4)
    }

    func test_searchForShows_shouldReturnThree() async throws {
        sut.changeSearch(index: 0)
        try await sut.search(for: "teste")
        XCTAssertEqual(sut.numberOfResults, 3)
    }

    func test_resetSearch_shouldClearResults() async throws {
        sut.changeSearch(index: 0)
        try await sut.search(for: "teste")
        XCTAssertEqual(sut.numberOfResults, 3)

        sut.resetSearch()
        XCTAssertEqual(sut.numberOfResults, 0)
    }

    func test_showDetailsForShow_shoudPresentShowDetails() async throws {
        sut.changeSearch(index: 0)
        try await sut.search(for: "teste")
        sut.showDetails(for: 2)

        XCTAssertTrue(spyRouter.hasPresentedDetailsForShow)
    }

    func test_showDetailsForPeople_shoudPresentPeopleDetails() async throws {
        sut.changeSearch(index: 1)
        try await sut.search(for: "teste")
        sut.showDetails(for: 2)

        XCTAssertTrue(spyRouter.hasPresentedDetailsForPerson)
    }

    func test_titleShouldBe_search() {
        XCTAssertEqual(sut.title, "Search")
    }

    func test_modelShowForCell_shouldHaveCorrectInfo() async throws {
        sut.changeSearch(index: 0)
        try await sut.search(for: "Teste")
        let model = sut.model(for: 0)!

        XCTAssertEqual(model.name, "Supernatural")
        XCTAssertEqual(model.image, "https://static.tvmaze.com/uploads/images/medium_portrait/268/672051.jpg")
        XCTAssertEqual(model.subtitle, "Drama Action Supernatural")
    }

    func test_modelPersonForCell_shouldHaveCorrectInfo() async throws {
        sut.changeSearch(index: 1)
        try await sut.search(for: "Teste")
        let model = sut.model(for: 0)!

        XCTAssertEqual(model.name, "Jennifer Knight")
        XCTAssertNil(model.image)
        XCTAssertEqual(model.subtitle, "Unknow")
    }

    func test_resultEmpty_shouldNotReturnAModel() {
        sut.resetSearch()
        XCTAssertNil(sut.model(for:0))
    }
}
