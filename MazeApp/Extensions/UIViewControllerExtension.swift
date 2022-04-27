//
//  UIViewControllerExtension.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit
extension UIViewController {
    func preferLargeTitles(isOn: Bool = true) {
        guard let controller = self.navigationController else { return }
        controller.navigationBar.prefersLargeTitles = isOn
        navigationItem.largeTitleDisplayMode = isOn ? .always : .never
        controller.navigationBar.largeTitleTextAttributes = controller.navigationBar.titleTextAttributes
    }
}
