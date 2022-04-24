//
//  UIFontExtension.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

extension UIFont {
    static func font(named name: String, size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.family: UIFont(name: "Helvetica", size: size)!.familyName
        ])

        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])

        return UIFont(descriptor: weightedFontDescriptor, size: size)
    }
}

