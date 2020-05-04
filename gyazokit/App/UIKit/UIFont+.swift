//
//  UIFont+.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
  static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
    let metrics = UIFontMetrics(forTextStyle: style)
    let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
    let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
    return metrics.scaledFont(for: font)
  }
}
