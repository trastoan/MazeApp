//
//  JSONLoader.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import Foundation

class JSONLoader {

    func loadJson<Model: Decodable>(named: String) -> Model? {
        guard let data = loadData(named: named) else { return nil }
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(Model.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }

    func loadData(named: String) -> Data? {
        let bundle = Bundle(for: JSONLoader.self)

        if let path = bundle.path(forResource: named, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print(error)
                return nil
            }
        }
       return nil
    }
}
