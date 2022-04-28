//
//  ShowDetailsSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 28/04/22.
//

@testable import MazeApp
import UIKit

class ShowDetailsServiceMock: ShowDetailServiceProtocol {
    var shouldReturnNoImage = false
    var shouldReturnNoEpisodes = false

    func listImages(showId: Int) async throws -> [ShowImage] {
        shouldReturnNoImage ? [] : ShowFixtures.showImages()
    }

    func listEpisodes(showId: Int) async throws -> [Episode] {
        shouldReturnNoEpisodes ? [] : EpisodeFixtures.episodeArray()
    }
}

class ShowDetailsRouterSpy: ShowDetailsRouterProtocol {
    var hasPresentedEpisodeDetails = true

    static func assembleModule(for show: Show) -> UIViewController {
        return UIViewController()
    }

    func presentEpisodeDetails(for episode: Episode) {
        hasPresentedEpisodeDetails = true
    }
}
