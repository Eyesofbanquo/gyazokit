//
//  ButtonBuilder.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import UIKit

extension UIButton {
  
  /// A builder used to create `UIButton`s.
  static func make(type: UIButton.ButtonType = .system,
                   font: UIFont? = .preferredFont(forTextStyle: .body),
                   title: String? = "Fill in",
                   textColor: UIColor? = .systemBlue) -> UIButton {
    return ButtonBuilder.build(type: type, font: font, title: title, textColor: textColor)
  }
}

/// A builder used to create `UIButton`s.
final class ButtonBuilder {
  
  static func build(type: UIButton.ButtonType = .system,
                    font: UIFont? = .preferredFont(forTextStyle: .body),
                    title: String? = "Fill in",
                    textColor: UIColor? = .systemBlue) -> UIButton {
    let button = UIButton(type: type)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.setTitleColor(textColor, for: .normal)
    button.titleLabel?.font = font
    
    return button
  }
  
}
