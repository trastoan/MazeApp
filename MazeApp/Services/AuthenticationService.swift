//
//  AuthenticationService.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import LocalAuthentication

protocol AuthenticationServiceProtocol {
    var keychainService: KeychainService { get set }

    func biometricAuthentication() async -> Bool
    func savePin(_ value: String, service: String) -> Bool
    func pinAuthentication(_ pin: String, service: String) -> Bool
}

class AuthenticationService: AuthenticationServiceProtocol {
    var keychainService = KeychainService()

    func biometricAuthentication() async -> Bool {
        await withCheckedContinuation({ continuation in
            biometricAuth { success in
                continuation.resume(returning: success)
            }
        })
    }

    func savePin(_ value: String, service: String = KeychainService.pinService) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return keychainService.save(data, service: service)
    }

    func pinAuthentication(_ pin: String, service: String = KeychainService.pinService) -> Bool {
        guard let data = keychainService.read(service: service),
              let storedPin = String(data: data, encoding: .utf8) else {
            return false
        }

        return pin == storedPin
    }

    private func biometricAuth(completion: @escaping (Bool) -> Void) {
        let authContext = LAContext()
        var policyError: NSError?

        authContext.localizedCancelTitle = "Enter Pin"
        let reason = "Unlock your app"

        if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &policyError) {
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { success, _ in
                    completion(success)
            })
        }
    }
}
