//
//  LabelBuilder.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
  
  static func make(font: UIFont = .preferredFont(forTextStyle: .body),
                   text: String = "Replace",
                   textColor: UIColor = .stored(named: .primaryDarkBackground)) -> UILabel {
    return LabelBuilder.build(font: font, text: text, textColor: textColor)
  }
}

/// A builder used to create `UILabel`s.
final class LabelBuilder {
  
  
  static func build(font: UIFont = .preferredFont(forTextStyle: .body),
             text: String = "Replace",
             textColor: UIColor = .stored(named: .primaryDarkBackground)) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.text = text
    label.textColor = textColor
    label.font = font
    
    return label
  }
}
