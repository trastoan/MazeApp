//
//  SceneDelegate.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        RootRouter.presentEntryController(in: window!)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        RootRouter.presentGuardController(in: window!)
    }

}

