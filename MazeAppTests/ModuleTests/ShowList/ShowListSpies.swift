//
//  ShowListSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

import UIKit
@testable import MazeApp

class ShowListServiceMock: ShowServiceProtocol {
    func listShows(page: Int) async throws -> [Show] {
        ShowFixtures.showArray()
    }
}

class ShowListRouterSpy: ShowListRouterProtocol {
    var hasPresentedDetailsForShow = false
    var hasPresentedConfigurations = false

    static func assembleModule() -> UIViewController {
        UIViewController()
    }

    func presentDetailsForShow(_ show: Show) {
        hasPresentedDetailsForShow = true
    }

    func presentConfigurations() {
        hasPresentedConfigurations = true
    }
}
