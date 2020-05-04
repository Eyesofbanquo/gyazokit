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
  
  lazy var passwords: Passwords = Passwords()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    
    authCancellable = authManager.authorize(in: self).receive(on: DispatchQueue.main).sink(receiveValue: { accessToken in
      print(accessToken)
    })
  }
}

