//
//  ShowListRouter.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

protocol ShowListRouterProtocol {
    static func assembleModule() -> UIViewController
    func presentDetailsForShow(_ show: Show)
    func presentConfigurations()
}

class ShowListRouter: ShowListRouterProtocol {
    private weak var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let router = ShowListRouter()
        let model = ShowListViewModel(router: router)
        let controller = ShowListController()

        controller.model = model
        router.viewController = controller

        let nav = UINavigationController(rootViewController: controller)
        nav.setAppearence(background: .appMainColor, tint: .white)
        controller.preferLargeTitles()

        return nav
    }

    func presentDetailsForShow(_ show: Show) {
        let destination = ShowDetailsRouter.assembleModule(for: show)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    func presentConfigurations() {
        let destination = SettingsRouter.assembleModule()
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
