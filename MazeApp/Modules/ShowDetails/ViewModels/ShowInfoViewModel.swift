//
//  ShowInfoViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

class ShowInfoViewModel {

    var summary: String
    var days: String
    var rating: String
    var time: String

    var hasAdditionalInfo: Bool {
        return !(days.isEmpty && rating == "0.0" && time.isEmpty)
    }

    init(summary: String, days: String, rating: String, time: String){
        self.summary = summary
        self.days = days
        self.rating = rating
        self.time = time
    }
}
