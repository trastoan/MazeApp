//
//  UIViewExtensions.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

extension UIView {
    func dropShadow(withOpacity opacity: Float = 0.2, radius: CGFloat = 3) {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 3, height: 4)
        self.layer.shadowRadius = radius
    }

    func centerOn(view: UIView) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
