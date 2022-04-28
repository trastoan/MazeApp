//
//  ShowDetailsViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import Foundation
@testable import MazeApp
import XCTest

class ShowDetailsViewModelTests: XCTestCase {
    var sut: ShowDetailViewModel!
    var mockService: ShowDetailsServiceMock!
    var spyRouter: ShowDetailsRouterSpy!
    var mockShow: Show!

    override func setUp() {
        spyRouter = ShowDetailsRouterSpy()
        mockService = ShowDetailsServiceMock()
        mockShow = ShowFixtures.show()
        sut = ShowDetailViewModel(show: mockShow, service: mockService, router: spyRouter)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        spyRouter = nil
    }

    func test_loadBackImage_success() async throws {
        try await sut.loadInfo()
        let expectedURL = URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/223/557688.jpg")!

        XCTAssertEqual(sut.backgroundImage, expectedURL)
    }

    func test_loadBackImage_error() async throws {
        mockService.shouldReturnNoImage = true
        try await sut.loadInfo()

        XCTAssertNil(sut.backgroundImage)
    }

    func test_formattShowDays_success() {
        let expected = " | Tue"

        let output = sut.formatShowDays()

        XCTAssertEqual(expected, output)
    }

    func test_formattShowDays_failure() {
        mockShow = ShowFixtures.missingInfoShow()
        sut = ShowDetailViewModel(show: mockShow, service: mockService, router: spyRouter)

        let output = sut.formatShowDays()
        XCTAssertTrue(output.isEmpty)
    }

    func test_buildSeasons_returnsTwo() async throws {
        try await sut.loadInfo()

        XCTAssertEqual(sut.seasons.count, 2)
    }

    func test_buildSeasonsWithNoEpisodes_returnsEmpty() async throws {
        mockService.shouldReturnNoEpisodes = true
        try await sut.loadInfo()

        XCTAssertTrue(sut.seasons.isEmpty)
    }

    func test_presentEpisodeDetails_callsRouter() {
        sut.presentEpisodeDetails(EpisodeFixtures.episode())

        XCTAssertTrue(spyRouter.hasPresentedEpisodeDetails)
    }

    func test_loadInfosUpdatesLoading_toFalse() async throws {
        sut.isLoading = true
        try await sut.loadInfo()

        XCTAssertFalse(sut.isLoading)
    }

    func test_buildInfoViewModel_success() {
        let output = sut.buildInfoViewModel()

        XCTAssertEqual(output.summary, mockShow.summary?.removeHTMLTags())
        XCTAssertEqual(output.days, " | Tue")
        XCTAssertEqual(output.time, "22:00")
        XCTAssertEqual(output.rating, "6.5")
        XCTAssertEqual(output.hasAdditionalInfo, true)
    }

    func test_buildInfoViewModel_noInfo() {
        mockShow = ShowFixtures.missingInfoShow()
        sut = ShowDetailViewModel(show: mockShow, service: mockService, router: spyRouter)
        let output = sut.buildInfoViewModel()

        XCTAssertEqual(output.summary, "None Available")
        XCTAssertEqual(output.days, "")
        XCTAssertEqual(output.time, "")
        XCTAssertEqual(output.rating, "Not Rated")
        XCTAssertEqual(output.hasAdditionalInfo, false)
    }

    func test_buildInfoViewModelPartialInfo_shouldShowAdditionalInfo() {
        mockShow = ShowFixtures.missingInfoShow()
        mockShow.rating = Rating(average: 4.6)
        sut = ShowDetailViewModel(show: mockShow, service: mockService, router: spyRouter)
        let output = sut.buildInfoViewModel()

        XCTAssertEqual(output.hasAdditionalInfo, true)
    }

    func test_buildHeaderViewModel_success() async throws {
        try await sut.loadInfo()

        let output = sut.buildHeaderViewModel()
        let expectedPosterURL = URL(string: mockShow.image!.medium)
        let expectedBackURL = sut.backgroundImage

        XCTAssertEqual(output.posterImage, expectedPosterURL)
        XCTAssertEqual(output.backgroundImage, expectedBackURL)
        XCTAssertEqual(output.genres, "Drama | Science-Fiction")
        XCTAssertEqual(output.network, "CBS")
        XCTAssertEqual(output.status, "Ended")
        XCTAssertEqual(output.numberOfSeasons, 2)
    }

    func test_buildHeaderViewModel_missingInfo() async throws {
        mockShow = ShowFixtures.missingInfoShow()
        mockService.shouldReturnNoImage = true
        mockService.shouldReturnNoEpisodes = true
        sut = ShowDetailViewModel(show: mockShow, service: mockService, router: spyRouter)

        try await sut.loadInfo()

        let output = sut.buildHeaderViewModel()

        XCTAssertNil(output.posterImage)
        XCTAssertNil(output.backgroundImage)
        XCTAssertTrue(output.genres.isEmpty)
        XCTAssertEqual(output.network, "Unknow")
        XCTAssertEqual(output.status, "Unknow")
        XCTAssertEqual(output.numberOfSeasons, 0)

    }

    func test_title_shouldBeEqualtoShowName(){
        XCTAssertEqual(sut.title, mockShow.name)
    }
}
