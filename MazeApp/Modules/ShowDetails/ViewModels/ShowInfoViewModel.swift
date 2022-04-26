//
//  ShowInfoViewModel.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import Foundation

protocol ShowInfoViewModelProtocol: ObservableObject {
    var summary: String { get }
    var days: String { get }
    var time: String { get }
    var rating: String { get }
}

class ShowInfoViewModel: ShowInfoViewModelProtocol {

    var summary: String
    var days: String
    var rating: String
    var time: String

    init(summary: String, days: String, rating: String, time: String){
        self.summary = summary
        self.days = days
        self.rating = rating
        self.time = time
    }
}
