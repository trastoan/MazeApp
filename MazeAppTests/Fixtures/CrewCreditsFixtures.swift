//
//  CrewCreditsFixtures.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation
@testable import MazeApp

class CrewCreditsFixtures {
    static func crewCreditsArray() -> [CrewCredits] {
        JSONLoader().loadJson(named: "CrewCredits")!
    }
}
