//
//  GuardRouter.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit

protocol GuardRouterProtocol {
    static func assembleModule() -> UIViewController
    func dismissController()
}

class GuardRouter: GuardRouterProtocol {
    var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let router = GuardRouter()
        let model = GuardViewModel(router: router)
        let controller = GuardViewController(model: model)

        router.viewController = controller

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.setTitleColor(.white)

        return nav
    }

    func dismissController() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
