//
//  PeopleDetailSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import UIKit
@testable import MazeApp

class PeopleDetailRouterSpy: PeopleDetailRouterProtocol {
    var hasShownDetails = false

    static func assembleModule(people: People) -> UIViewController {
        return UIViewController()
    }

    func presentShowDetails(show: Show) {
        hasShownDetails = true
    }
}

class PeopleDetailServiceMock: PeopleDetailServiceProtocol {
    func listCastCredits(_ id: Int) async throws -> [CastCredits] {
        return CastCreditsFixtures.castCreditsArray()
    }

    func listCrewCredits(_ id: Int) async throws -> [CrewCredits] {
        return CrewCreditsFixtures.crewCreditsArray()
    }
}
