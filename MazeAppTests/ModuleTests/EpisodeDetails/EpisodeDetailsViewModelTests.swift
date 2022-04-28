//
//  EpisodeDetailsViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import XCTest
@testable import MazeApp

class EpisodeDetailsViewModelTests: XCTestCase {
    var sut: EpisodeDetailsViewModel!
    var mockedEpisode: Episode!

    override func setUp() {
        mockedEpisode = EpisodeFixtures.episode()
        sut = EpisodeDetailsViewModel(router: EpisodeDetailsRouter(), episode: mockedEpisode)
    }

    override func tearDown() {
        mockedEpisode = nil
        sut = nil
    }

    func test_buildHeaderInfoPerfectEpisode_hasCorrectInfos() {
        let modelOutput = sut.buildHeaderModel()

        let expectedNumber = String(format: "S%02d | E%02d", mockedEpisode.season, mockedEpisode.number)
        let expectedPoster = URL(string: mockedEpisode.image!.original)

        XCTAssertEqual(modelOutput.poster, expectedPoster)
        XCTAssertEqual(modelOutput.number, expectedNumber)
        XCTAssertEqual(modelOutput.title, mockedEpisode.name)
    }

    func test_buildHeaderInfoNoImage_hasURLNil() {
        mockedEpisode.image = nil
        sut = EpisodeDetailsViewModel(router: EpisodeDetailsRouter(), episode: mockedEpisode)
        let modelOutput = sut.buildHeaderModel()


        XCTAssertNil(modelOutput.poster)
    }

    func test_buildInfoPerfectEpisode_hasCorrectInfos() {
        let modelOutput = sut.buildInfoModel()

        let expectedRating = mockedEpisode.rating!.average!
        let expectedAirDate = sut.airDateFormatted(mockedEpisode.airdate)

        XCTAssertEqual(modelOutput.rating, "\(expectedRating)")
        XCTAssertEqual(modelOutput.summary, mockedEpisode.summary?.removeHTMLTags())
        XCTAssertEqual(modelOutput.time, mockedEpisode.airtime)
        XCTAssertEqual(modelOutput.days, expectedAirDate)
    }

    func test_airDateFormatterNilInput_returnsUnknow() {
        let output = sut.airDateFormatted(nil)

        XCTAssertEqual(output, "Unknow")
    }

    func test_airDateFormatterInvalidInput_returnsUnknow() {
        let output = sut.airDateFormatted("12-03-2022")

        XCTAssertEqual(output, "Unknow")
    }

    func test_infoHeader_withIncompleteEpisode() {
        mockedEpisode.summary = nil
        mockedEpisode.rating = nil
        mockedEpisode.airtime = nil

        sut = EpisodeDetailsViewModel(router: EpisodeDetailsRouter(), episode: mockedEpisode)
        let modelOutput = sut.buildInfoModel()

        XCTAssertEqual(modelOutput.rating, "0.0")
        XCTAssertEqual(modelOutput.summary, "Not available")
        XCTAssertTrue(modelOutput.time.isEmpty)
    }
}

