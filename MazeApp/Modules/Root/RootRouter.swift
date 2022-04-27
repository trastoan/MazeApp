//
//  RootRouter.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

protocol RootRouterProtocol {
    static func presentEntryController(in window: UIWindow)
    static func presentGuardController(in window: UIWindow)
}

class RootRouter {
    static func presentEntryController(in window: UIWindow) {
        window.rootViewController = ApplicationTabBarController()
        window.makeKeyAndVisible()
    }

    static func presentGuardController(in window: UIWindow) {
        if UserDefaults.authenticationEnabled {
            let destination = GuardRouter.assembleModule()
            guard let appTabController = window.rootViewController as? UITabBarController  else { return }

            if appTabController.presentedViewController == nil {
                appTabController.selectedViewController?.present(destination, animated: true)
            } else {
                appTabController.presentedViewController?.present(destination, animated: true)
            }

        }
    }
}
