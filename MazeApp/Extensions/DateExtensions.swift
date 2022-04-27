//
//  DateExtensions.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

extension Date {
    func yearsBetweenDate(endDate: Date) -> Int? {
        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: self, to: endDate)

        return components.year
    }
}
