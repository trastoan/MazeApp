//
//  EpisodeFixtures.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation
@testable import MazeApp

class EpisodeFixtures {
    static func episodeArray() -> [Episode] {
        JSONLoader().loadJson(named: "Episodes")!
    }

    static func episode() -> Episode {
        JSONLoader().loadJson(named: "Episode")!
    }
}
