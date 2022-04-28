//
//  PinRegistrationModelSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import UIKit
@testable import MazeApp

class SpyPinRegistrationRouter: PinRegistrationRouterProtocol {
    var hasDissmissed = false

    static func assembleModule() -> UIViewController {
        return UIViewController()
    }

    func dismissController() {
        hasDissmissed = true
    }
}
