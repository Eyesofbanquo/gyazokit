//
//  Passwords.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/3/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import KeychainAccess

/// This class is responsible for storing sensitive information into either the `keychain` or `user defaults`.
final class Passwords {
  
  // MARK: - Static -
  
  /// This service is used to link all instances of the keychain with the app bundle
  static fileprivate var keychainService: String = "com.donderapps.gyazo"
  
  /// The keychain object. It is marked as static since there should only ever be one instance but private since no other file should have knowledge of this.
  static fileprivate var keychain: Keychain = {
    let keychain = Keychain(service: keychainService)
    return keychain
  }()
  
  /// Saves a key/value pair to either the keychain or the user defaults
  @discardableResult
  func save(key: PasswordKey, value: String?, to type: PasswordType) -> Bool {
    guard let value = value else {
      return false
    }
    
    switch type {
      case .keychain:
        Self.keychain[key.unlock()] = value
        return true
      default: return false
    }
  }
  
  /// Returns the given `key` as the argument `type`. Returns `nil` if the value was not stored as the specififed `type`
  /// - Parameters:
  ///   - type: The type the `key` was saved as. **Required**
  ///   - key: The key you're trying to access. **Required**
  ///   - storageMethod: The method in which the key was stored: `keychain` or `user defaults`. Defaults to `keychain`.
  func retrieve<T>(type: T.Type, fromKey key: PasswordKey, fromStorage storageMethod: PasswordType = .keychain) -> T? {
    
    switch storageMethod {
      case .keychain: return Self.keychain[key.unlock()] as? T
      case .defaults: return nil
    }
    
  }
}

// MARK: - Static  -

extension Passwords {
  
}
