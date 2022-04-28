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

    static func show() -> Show {
        JSONLoader().loadJson(named: "Show")!
    }
}
