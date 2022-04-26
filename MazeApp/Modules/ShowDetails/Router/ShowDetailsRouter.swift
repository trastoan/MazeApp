//
//  ShowDetailsRouter.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation
import UIKit
import SwiftUI

protocol ShowDetailsRouterProtocol {
    static func assembleModule(for show: Show) -> UIViewController
    func presentEpisodeDetails(for episode: Episode)
    func presentPersonDetails(for person: People)
}

class ShowDetailsRouter: ShowDetailsRouterProtocol {
    weak var viewController: UIViewController?

    static func assembleModule(for show: Show) -> UIViewController {
        let model = ShowDetailViewModel(show: show)
        let view = ShowDetailsView(model: model)
        let router = ShowDetailsRouter()

        model.router = router
        let controller = UIHostingController(rootView: view)
        controller.title = model.title
        router.viewController = controller

        return controller
    }

    func presentEpisodeDetails(for episode: Episode) {
        print("presenting episode \(episode.number)")
    }

    func presentPersonDetails(for person: People) {
        //TBD
    }

}
