//
//  PeopleDetailViewModelTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

class PeopleDetailViewModelTests: XCTestCase {
    var sut: PeopleViewModel!
    var spyRouter: PeopleDetailRouterSpy!
    var mockService: PeopleDetailServiceMock!

    override func setUp() {
        spyRouter = PeopleDetailRouterSpy()
        mockService = PeopleDetailServiceMock()
        sut = PeopleViewModel(router: spyRouter,
                              people: PeopleFixtures.people(),
                              service: mockService)
        
    }

    override func tearDown() {
        spyRouter = nil
        mockService = nil
        sut = nil
    }

    func test_whenShowSelected_presentDetails() {
        sut.presentShowDetail(show: ShowFixtures.show())

        XCTAssertTrue(spyRouter.hasShownDetails)
    }

    func test_loadRelatedShows_shouldReturnThree() async throws{
        try await sut.loadRelatedInfo()

        XCTAssertEqual(sut.shows.count, 3)
    }

    func test_buildDetailHeader_shouldBeCorrect() {
        let person = PeopleFixtures.people()
        let newSut = PeopleViewModel(router: spyRouter, people: person)
        let detailHeader = newSut.buildHeaderModel()
        XCTAssertEqual(detailHeader.age, person.age)
        XCTAssertEqual(detailHeader.name, person.name)
        XCTAssertEqual(detailHeader.country, person.country?.name)
    }

    func test_buildDetailHeader_personWithoutCountry_returnsUnknow() {
        let person = PeopleFixtures.peopleWithoutCountry()
        let newSut = PeopleViewModel(router: spyRouter, people: person)
        let detailHeader = newSut.buildHeaderModel()

        XCTAssertEqual(detailHeader.country, "Country Unknow")
    }

    func test_buildDetailHeader_emptyPoster() {
        var person = PeopleFixtures.peopleWithoutCountry()
        person.image = nil
        let newSut = PeopleViewModel(router: spyRouter, people: person)
        let detailHeader = newSut.buildHeaderModel()

        XCTAssertNil(detailHeader.poster)
    }
}

