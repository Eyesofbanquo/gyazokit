//
//  ViewController.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/3/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import UIKit

class ViewController: UIViewController {
  
  // MARK: - Receivers -
  
  var authCancellable: AnyCancellable?
  
  // MARK: - Layers -
  
  lazy var authManager: AuthManager = AuthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    
    authCancellable = authManager.authorize(in: self).sink { success in
      print(success)
    }
  }
}

