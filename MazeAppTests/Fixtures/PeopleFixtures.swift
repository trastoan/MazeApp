//
//  PeopleFixtures.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation
@testable import MazeApp

class PeopleFixtures {
    static func peopleArray() -> [People] {
        JSONLoader().loadJson(named: "Peoples")!
    }

    static func people() -> People {
        JSONLoader().loadJson(named: "People")!
    }
}
