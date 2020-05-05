//
//  Authorizable.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import Foundation
import UIKit

protocol Authorizable: AnyObject {
  func authorize(in controller: UIViewController?) -> Future<String?, Never>
}
