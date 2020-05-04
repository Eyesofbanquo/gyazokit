//
//  UIColor+.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation
import UIKit

enum StoredColor: String {
  case primaryDarkBackground
  case secondaryDarkBackground
  case primaryLightBackground
}

extension UIColor {
  
  static func stored(named: StoredColor) -> UIColor {
    return UIColor(named: named.rawValue)!
  }
  
}
