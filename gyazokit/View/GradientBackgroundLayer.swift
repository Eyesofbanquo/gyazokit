//
//  LoginBackgroundView.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Hue
import SnapKit
import UIKit

/// A background gradient layer that currently only supports 2 colors
final class GradientBackgroundLayer: CAGradientLayer {
  
  init(fromHex: String, toHex: String) {
    super.init()
  }
  
  @available(*, unavailable, message: "Use the hex init instead")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
