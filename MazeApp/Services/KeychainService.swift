//
//  KeychainService.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import Foundation

class KeychainService {
    static var pinService = "SecurityPin"
    var account = "MazeApp"

    func save(_ data: Data, service: String) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            print("Error: \(status)")
            if status == errSecDuplicateItem {
                return update(data: data, service: service)
            }
            return false
        }

        return true
    }

    func update(data: Data, service: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let attrToUpdate = [kSecValueData: data] as CFDictionary
        let status = SecItemUpdate(query, attrToUpdate)
        if status != errSecSuccess {
            print("Error: \(status)")
            return false
        }
        return true
    }

    func read(service: String) -> Data? {
        let query = [
               kSecAttrService: service,
               kSecAttrAccount: account,
               kSecClass: kSecClassGenericPassword,
               kSecReturnData: true
           ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return result as? Data
    }

    func delete(service: String) -> Bool {
        let query = [
               kSecAttrService: service,
               kSecAttrAccount: account,
               kSecClass: kSecClassGenericPassword
           ] as CFDictionary

        let status = SecItemDelete(query)

        if status != errSecSuccess {
            print("Error: \(status)")
            return false
        }
        return true
    }

}
