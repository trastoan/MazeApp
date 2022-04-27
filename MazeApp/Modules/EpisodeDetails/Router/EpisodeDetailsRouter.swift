//
//  EpisodeDetailsRouter.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import UIKit
import SwiftUI

protocol EpisodeDetailsRouterProtocol {
    static func assembleModule(with episode: Episode) -> UIViewController
}

class EpisodeDetailsRouter: EpisodeDetailsRouterProtocol {
    weak var viewController: UIViewController?

    static func assembleModule(with episode: Episode) -> UIViewController {
        let router = EpisodeDetailsRouter()
        let model = EpisodeDetailsViewModel(router: router, episode: episode)
        let view = EpisodeDetailsView(model: model)

        let controller = UIHostingController(rootView: view)
        controller.view.backgroundColor = .clear
        router.viewController = controller

        return controller
    }
}
