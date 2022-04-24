//
//  NavigationControllerExtension.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

extension UINavigationController {
    func setAppearence(background: UIColor, tint: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = background
        appearence.shadowColor = .clear
        appearence.titleTextAttributes = [.foregroundColor : tint]
        appearence.largeTitleTextAttributes = [.foregroundColor : tint]

        navigationBar.standardAppearance = appearence
        navigationBar.tintColor = tint
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }

    func setTitleColor(_ color: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.titleTextAttributes = [.foregroundColor : color]
        appearence.largeTitleTextAttributes = [.foregroundColor : color]

        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }

    func preferLargeTitles(isOn: Bool = true) {
        navigationBar.prefersLargeTitles = isOn
        navigationItem.largeTitleDisplayMode = isOn ? .always : .never
        navigationBar.largeTitleTextAttributes = navigationBar.titleTextAttributes
    }
}
