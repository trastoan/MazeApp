//
//  ArrayExtension.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation
extension Array {
    func unique() -> Array where Element: Hashable {
        let unique = Set(self)
        return Array(unique)
    }
}
