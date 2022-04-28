//
//  ShowFixtures.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation
@testable import MazeApp

class ShowFixtures {
    static func showArray() -> [Show] {
        JSONLoader().loadJson(named: "Shows")!
    }

    static func showSearchArray() -> [ShowSearch] {
        JSONLoader().loadJson(named: "ShowSearch")!
    }

    static func missingInfoShow() -> Show {
        Show(id: 1, name: "Teste", image: nil, genres: [], summary: nil, status: nil, schedule: nil, rating: nil, network: nil)
    }

    static func show() -> Show {
        JSONLoader().loadJson(named: "Show")!
    }

    static func showImages() -> [ShowImage] {
        JSONLoader().loadJson(named: "Images")!
    }
}
