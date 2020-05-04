//
//  StackViewBuilder.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
  
  /// The default `UIStackView` with vertical axis, center alignment, filled distribution, and 8.0 spacing.
  static var `default`: UIStackView = StackViewBuilder.build()
}

/// A builder responsible for creating stack views
final class StackViewBuilder {
  
  
  /// A builder used for creating `UIStackView`s.
  /// - Parameters:
  ///   - axis: The axis in which the content is on. Either horizontal or vertical
  ///   - alignment: How the content on the axis is aligned. This is perpendicular to the `axis`
  ///   - distribution: How the content is distributed
  ///   - spacing: How the content is spaced from  other elements in the stack.
  static func build(axis: NSLayoutConstraint.Axis = .vertical,
                    alignment: UIStackView.Alignment = .center,
                    distribution: UIStackView.Distribution = .fill,
                    spacing: CGFloat = 8.0) -> UIStackView {
    let stackView: UIStackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.axis = axis
    stackView.alignment = alignment
    stackView.distribution = distribution
    stackView.spacing = spacing
    
    return stackView
  }
}
