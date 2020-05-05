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
  
  private let loginView: LoginView
  
  // MARK: - Properties -
  
  private var authManager: Authorizable
  
  lazy var passwords: Passwords = Passwords()
  
  // MARK: - Subscribers -
  
  var loginButtonTapped: AnyCancellable?
  
  // MARK: - Init -
  
  init(view: LoginView = LoginView(),
       authManager: Authorizable = AuthManager()) {
    self.loginView = view
    self.authManager = authManager
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  
  override func loadView() {
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    observeLoginButton()
  }
}

// MARK: - Receivers -

extension LoginViewController {
  
  private func observeLoginButton() {
    
    loginButtonTapped = loginView.loginPressedPassthrough
      .receive(on: DispatchQueue.main)
      .flatMap { [unowned self] event in
        return self.authManager.authorize(in: self)
    }
    .sink { [unowned self] accessToken in
      self.passwords.save(key: .accessToken, value: accessToken, to: .keychain)
    }
  }
  
}
