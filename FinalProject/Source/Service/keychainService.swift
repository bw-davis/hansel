//
//  keychainService.swift
//  FinalProject
//
//  Created by Nathan Nichols on 10/3/16.
//
//

import Foundation
import Security


public class KeychainService {
    // MARK: Public
    public func addPasswordItemForAccount(account: String, withData data: NSData) -> Bool {
        guard !account.isEmpty && data.length > 0 else {
            return false
        }
        
        var requestDictionary = requestDictionaryForPasswordItemForAccount(account)
        requestDictionary[kSecValueData as String] = data
        
        guard SecItemAdd(requestDictionary, nil) == OSStatus(errSecSuccess) else {
            return false
        }
        
        return true
    }
    
    public func updatePasswordItemForAccount(account: String, withData data: NSData) -> Bool {
        guard !account.isEmpty && data.length > 0 else {
            return false
        }
        
        let requestDictionary = requestDictionaryForPasswordItemForAccount(account)
        let attributesDictionary = [kSecValueData as String : data] as CFDictionary
        
        guard SecItemUpdate(requestDictionary, attributesDictionary) == OSStatus(errSecSuccess) else {
            return addPasswordItemForAccount(account, withData: data)
        }
        
        return true
    }
    
    public func deletePasswordItemForAccount(account: String) -> Bool {
        guard !account.isEmpty else {
            return false
        }
        
        let requestDictionary = requestDictionaryForPasswordItemForAccount(account)
        
        guard SecItemDelete(requestDictionary) == OSStatus(errSecSuccess) else {
            return false
        }
        
        return true
    }
    
    public func dataForPasswordItemForAccount(account: String) -> NSData? {
        guard !account.isEmpty else {
            return nil
        }
        
        var requestDictionary = requestDictionaryForPasswordItemForAccount(account)
        requestDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        requestDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(requestDictionary, &result);
        guard let data = result as? NSData where status == OSStatus(errSecSuccess) else {
            return nil
        }
        
        return data
    }
    
    // MARK: Private
    private func requestDictionaryForPasswordItemForAccount(account: String) -> Dictionary<String, AnyObject> {
        var requestDictionary = Dictionary<String, AnyObject>()
        requestDictionary[kSecClass as String] = kSecClassGenericPassword
        requestDictionary[kSecAttrAccount as String] = account
        requestDictionary[kSecAttrService as String] = account
        
        return requestDictionary
    }
    
    // MARK: Initialization
    private init() {
        // Empty init method implemented for access control (i.e., to be private)
    }
    
    // MARK: Properties
    static var sharedKeychainService = KeychainService()
}
