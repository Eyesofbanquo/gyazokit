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
  func save(key: String, value: String?, to type: PasswordsType) -> Bool {
    guard let value = value else {
      return false
    }
    
    switch type {
      case .keychain:
        Self.keychain[key] = value
        return true
      default: return false
    }
  }
}

extension Passwords {
  enum PasswordsType {
    case keychain
    case defaults
  }
}
