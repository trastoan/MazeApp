//
//  ShowListViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import XCTest
@testable import MazeApp

class ShowListViewModelTests: XCTestCase {
    var sut: ShowListViewModel!
    var spyRouter: ShowListRouterSpy!
    var mockService: ShowListServiceMock!
    var hasCalledFinishedFetch = false


    override func setUp() {
        spyRouter = ShowListRouterSpy()
        mockService = ShowListServiceMock()
        sut = ShowListViewModel(service: mockService, router: spyRouter)
        sut.hasFinishedFetch = { [weak self] in self?.hasCalledFinishedFetch = true }
    }

    override func tearDown() {
        sut = nil
        spyRouter = nil
        mockService = nil
    }

    func test_titleShouldbe_discover() {
        XCTAssertEqual(sut.title, "Discover")
    }

    func test_shouldCallFinishFetch_true() async throws {
        try await sut.fetch()
        XCTAssertTrue(hasCalledFinishedFetch)
    }

    func test_fetchNextPageShouldChangeCurrentPage() async throws {
        XCTAssertEqual(sut.currentPage, 0)
        try await sut.fetchNextPage()

        XCTAssertEqual(sut.currentPage, 1)
    }

    func test_buildNewIndexes_shouldReturnThree() async throws {
        try await sut.fetch()
        try await sut.fetchNextPage()

        let output = sut.buildNewIndexes(from: 3)

        XCTAssertEqual(output, [IndexPath(row: 3, section: 0),
                                IndexPath(row: 4, section: 0),
                                IndexPath(row: 5, section: 0),])
    }

    func test_shouldShowDetailsForShow_true() async throws {
        try await sut.fetch()
        sut.showDetails(for: 0)

        XCTAssertTrue(spyRouter.hasPresentedDetailsForShow)
    }

    func test_shouldShowConfigurations_true() {
        sut.showConfigurations()

        XCTAssertTrue(spyRouter.hasPresentedConfigurations)
    }

    func test_showForIndex_retunsCorrectOne() async throws {
        try await sut.fetch()
        let output = sut.show(for: 0)

        XCTAssertEqual(output.name, "Under the Dome")
    }
}
