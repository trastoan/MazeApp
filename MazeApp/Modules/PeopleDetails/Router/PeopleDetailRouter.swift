//
//  PeopleDetailRouter.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import UIKit
import SwiftUI

protocol PeopleDetailRouterProtocol {
    static func assembleModule(people: People) -> UIViewController
    func presentShowDetails(show: Show)
}

class PeopleDetailRouter: PeopleDetailRouterProtocol {
    weak var viewController: UIViewController?

    static func assembleModule(people: People) -> UIViewController {
        let router = PeopleDetailRouter()
        let model = PeopleViewModel(router: router, people: people)
        let view = PeopleDetailView(model: model)

        let controller = UIHostingController(rootView: view)
        controller.title = people.name
        router.viewController = controller

        return controller
    }

    func presentShowDetails(show: Show) {
        let destination = ShowDetailsRouter.assembleModule(for: show)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

}
