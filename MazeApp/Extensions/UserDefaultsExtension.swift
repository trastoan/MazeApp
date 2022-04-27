//
//  UserDefaultsExtension.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation
extension UserDefaults {
    static let authenticationEnabledKey = "authenticationEnabled"
    static let biometricEnabledKey = "biometricsEnabled"

    static var authenticationEnabled: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.authenticationEnabledKey)
    }

    static var biometricsEnabled: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.biometricEnabledKey)
    }
}
