//
//  PasswordKey.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation

enum PasswordKey: String {
  case accessToken
  
  /// This returns the `rawValue` of the `enum` type by "unlocking" it.
  func unlock() -> String {
    return rawValue
  }
}
