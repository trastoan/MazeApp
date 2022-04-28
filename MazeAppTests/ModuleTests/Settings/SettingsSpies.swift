//
//  SettingsSpies.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import UIKit
@testable import MazeApp

class SpySettingsRouter: SettingsRouterProtocol  {

    var hasCalledRegistration = false

    static func assembleModule() -> UIViewController {
        return UIViewController()
    }

    func registerNewPin() {
        hasCalledRegistration = true
    }
}
