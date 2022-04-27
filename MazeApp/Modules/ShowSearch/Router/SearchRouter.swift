//
//  ShowSearchRouter.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

protocol SearchRouterProtocol {
    static func assembleModule() -> UIViewController
    func presentDetailsForShow(_ show: Show)
    func presentDetailsForPeople(_ people: People)
}

class SearchRouter: SearchRouterProtocol {
    private weak var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let controller = SearchView()
        let model = SearchViewModel()
        let router = SearchRouter()

        controller.model = model
        model.router = router
        router.viewController = controller

        let nav = UINavigationController(rootViewController: controller)
        nav.setAppearence(background: .appMainColor, tint: .white)

        return nav
    }

    func presentDetailsForShow(_ show: Show) {
        let destination = ShowDetailsRouter.assembleModule(for: show)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    func presentDetailsForPeople(_ people: People) {
        let destination = PeopleDetailRouter.assembleModule(people: people)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
