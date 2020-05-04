//
//  LoginViewController.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class LoginViewController: UIViewController {
  
  // MARK: - Views -
  
  var loginView: LoginView? {
    return self.view as? LoginView
  }
  
  // MARK: - Properties -
  
  lazy var authManager: AuthManager = AuthManager()
  
  lazy var passwords: Passwords = Passwords()
  
  // MARK: - Subscribers -
  
  var loginButtonTapped: AnyCancellable?
  
  // MARK: - Init -
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  
  override func loadView() {
    let view = LoginView()
    
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    observeLoginButton()
  }
}

// MARK: - Receivers -

extension LoginViewController {
  
  private func observeLoginButton() {
    loginButtonTapped = loginView?.loginPressedPassthrough
      .receive(on: DispatchQueue.main)
      .flatMap { [unowned self] _  in
        return self.authManager.authorize(in: self)
    }
    .sink { [unowned self] accessToken in
      print(accessToken)
      self.passwords.save(key: .accessToken, value: accessToken, to: .keychain)
    }
  }
  
}
