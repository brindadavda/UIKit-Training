//
//  KeychainCrudOperation.swift
//  demoKeyChain
//
//  Created by apple on 15/04/24.
//

import UIKit

//MARK :- UserName , Password store data in keychain
final class Keychain : KeychainDelegate{
    static let shared = Keychain()
    
    private var item: CFTypeRef?

    func saveData(username: String, password: Data) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password,
        ]

        let status = SecItemAdd(attributes as CFDictionary, nil)
        print("\(#function) :- \(status) & statusCode \(status)")

        if status == errSecSuccess {
            print("User saved successfully in the keychain")
        } else if status == errSecDuplicateItem {
            print("Item already exists in the keychain")
        } else {
            print("\(#function) ⚠️ something went wrong")
            print("Something went wrong trying to save the user in the keychain")
            if let errorMessage = SecCopyErrorMessageString(status, nil) {
                print("Error: \(errorMessage)")
            }
        }
    }

    
    func retriveData(username: String) {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?
        
        // Check if user exists in the keychain
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess {
            // Extract result
            if let existingItem = item as? [String: Any],
               let retrievedUsername = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                print("Username = \(retrievedUsername)")
                print("Password = \(password)")
            }
        } else if status == errSecItemNotFound {
            print("User not found in the keychain")
        } else {
            print("Something went wrong trying to retrieve the user from the keychain")
            if let errorMessage = SecCopyErrorMessageString(status, nil) {
                print("Error: \(errorMessage)")
            }
        }
    }


   
    func updateData(username: String, updatedUser: User) {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Set attributes for the new password
        let attributes: [String: Any] = [kSecValueData as String: updatedUser.password]
        // Find user and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            print("Password has changed")
        } else {
            print("Something went wrong trying to update the password")
        }
    }
    
    func deleteUser(username: String) {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("User removed successfully from the keychain")
        } else {
            print("Something went wrong trying to remove the user from the keychain")
        }
    }
    
}
