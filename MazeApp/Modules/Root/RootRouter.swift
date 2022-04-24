//
//  RootRouter.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

protocol RootRouterProtocol {
    static func presentEntryController(in window: UIWindow)
}

class RootRouter {
    static func presentEntryController(in window: UIWindow) {
        window.rootViewController = ApplicationTabBarController()
        window.makeKeyAndVisible()
    }
}
