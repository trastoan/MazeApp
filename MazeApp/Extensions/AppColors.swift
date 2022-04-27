//
//  AppColors.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import UIKit
import SwiftUI

extension UIColor {
  convenience init(light: UIColor, dark: UIColor) {
    self.init { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .light, .unspecified:
        return light
      case .dark:
        return dark
      @unknown default:
        return light
      }
    }
  }
}

extension Color {
    init(light: Color, dark: Color) {
        self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
      }
}

extension Color {
    static let defaultCardColor = Color(light: .white,
                                        dark: Color(red: 0.2, green: 0.2, blue: 0.2))

    static let defaultBackground = Color(light: Color(red: 0.94, green: 0.94, blue: 0.94),
                                         dark: Color(red: 0.1, green: 0.1, blue: 0.1))

    static let appMainColor = Color(light: Color(red: 0.24, green: 0.58, blue: 0.55),
                                      dark: Color(red: 0.24, green: 0.58, blue: 0.55))
}

extension UIColor {
    static let defaultCardColor = UIColor(light: .white,
                                          dark: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))

    static let defaultBackground = UIColor(light: UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1),
                                           dark: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))

    static let appMainColor = UIColor(light: UIColor(red: 0.24, green: 0.58, blue: 0.55, alpha: 1),
                                      dark: UIColor(red: 0.24, green: 0.58, blue: 0.55, alpha: 1))

    static let segmentedBackground = UIColor(light: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1),
                                             dark: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))
}
