//
//  SettingServices.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation
class SettingServices {
    var userDefaults: UserDefaults

    let authenticationEnabledKey = "authenticationEnabled"
    let biometricEnabledKey = "biometricsEnabled"

    init(defaults: UserDefaults = .standard) {
        self.userDefaults = defaults
    }

    var authenticationEnabled: Bool {
        get { userDefaults.bool(forKey: authenticationEnabledKey)}
        set { userDefaults.set(newValue, forKey: authenticationEnabledKey)}
    }

    var biometricsEnabled: Bool {
        get { userDefaults.bool(forKey: biometricEnabledKey)}
        set { userDefaults.set(newValue, forKey: biometricEnabledKey)}
    }
}
