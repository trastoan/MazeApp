//
//  StringsExtension.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

extension String {
    func removeHTMLTags() -> String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
