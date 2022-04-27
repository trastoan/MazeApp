//
//  ShowImage.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import Foundation

struct ShowImage: Decodable {
    var type: String?
    var resolutions: Resolution?
    var originalURL: String? { resolutions?.original?.url }

    struct Resolution: Decodable {
        var original: ImageInfo?
        var medium: ImageInfo?

     }

    struct ImageInfo: Decodable {
        var url: String
    }

}
