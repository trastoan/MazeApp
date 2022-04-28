//
//  SearchSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import UIKit
@testable import MazeApp

class SearchRouterSpy: SearchRouterProtocol {
    var hasPresentedDetailsForShow = false
    var hasPresentedDetailsForPerson = false

    static func assembleModule() -> UIViewController { UIViewController() }

    func presentDetailsForShow(_ show: Show) {
        hasPresentedDetailsForShow = true
    }

    func presentDetailsForPeople(_ people: People) {
        hasPresentedDetailsForPerson = true
    }
}

class SearchServiceMock: SearchServiceProtocol {
    func searchFor<T>(endpoint: SearchEndpoint) async throws -> [T] where T : Decodable {
        switch endpoint {
            case .show:
                return ShowFixtures.showSearchArray() as! [T]
            case .people:
                return PeopleFixtures.peopleSearchArray() as! [T]
        }
    }
}
