//
//  CastCreditsFixture.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation
@testable import MazeApp

class CastCreditsFixtures {
    static func castCreditsArray() -> [CastCredits] {
        JSONLoader().loadJson(named: "CastCredits")!
    }
}
