//
//  PinRegistrationRouter.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit
protocol PinRegistrationRouterProtocol {
    static func assembleModule() -> UIViewController
    func dismissController()
}

class PinRegistrationRouter: PinRegistrationRouterProtocol {
    var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let router = PinRegistrationRouter()
        let model = PinRegistrationViewModel(router: router)
        let controller = PinRegistrationViewController(model: model)

        router.viewController = controller
        model.router = router
        controller.model = model

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.setTitleColor(.white)

        return nav
    }

    func dismissController() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
