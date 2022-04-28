//
//  JSONLoader.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation

class JSONLoader {

    func loadJson<Model: Decodable>(named: String) -> Model? {
        let bundle = Bundle(for: JsonLoader.self)

        if let path = bundle.path(forResource: named, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(Model.self, from: data)
            } catch {
                print(error)
                return nil
            }
        }
       return nil
    }
}
