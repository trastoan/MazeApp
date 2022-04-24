//
//  ApplicationTabBarController.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

class ApplicationTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()

        let showListController = ShowListRouter.assembleModule()

        showListController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "calendar"), tag: 1)

        let tabBarControllers = [showListController]
        self.setViewControllers(tabBarControllers, animated: true)
    }

    func setupAppearence() {
        tabBar.backgroundColor = .systemBackground
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .systemBlue
    }
}
