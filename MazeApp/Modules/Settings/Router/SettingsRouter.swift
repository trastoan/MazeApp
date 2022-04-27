//
//  SettingsRouter.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit
import SwiftUI

class SettingsRouter {
    var viewController: UIViewController?

    static func assembleModule() -> UIHostingController<SettingsView> {
        let model = SettingsViewModel()
        let router = SettingsRouter()
        let view = SettingsView(with: model)
        let controller = UIHostingController(rootView: view)

        controller.title = "Configurations"
        controller.navigationController?.preferLargeTitles(isOn: false)

        model.router = router
        router.viewController = controller

        return controller
    }

    func registerNewPin() {
        let destination = PinRegistrationRouter.assembleModule()
        viewController?.present(destination, animated: true)
    }
}
