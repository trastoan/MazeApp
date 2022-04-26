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
        let searchController = SearchRouter.assembleModule()

        showListController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "calendar"), tag: 1)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)

        let tabBarControllers = [showListController, searchController]
        self.setViewControllers(tabBarControllers, animated: true)
    }

    func setupAppearence() {
        tabBar.backgroundColor = .systemBackground
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .appMainColor
    }
}
