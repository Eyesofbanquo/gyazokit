//
//  LoginView.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/4/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import SnapKit
import UIKit

final class LoginView: UIView {
  
  // MARK - Subviews -
  
  private lazy var mainStackView: UIStackView = .default
  
  private lazy var loginButton: UIButton = .make(title: "Login",
                                                 textColor: .stored(named: .primaryDarkBackground))
  
  private lazy var loginLabel: UILabel = .make(text: "Please login",
                                               textColor: .systemPink)
  
  // MARK: - Passthroughs -
  
  lazy var loginPressedPassthrough: PassthroughSubject<UIControl.Event, Never> = PassthroughSubject<UIControl.Event, Never>()
  
  // MARK: - Init -
  
  init() {
    super.init(frame: .zero)
    
    self.backgroundColor = .stored(named: .primaryLightBackground)
    
    mainStackView.addArrangedSubview(loginLabel)
    mainStackView.addArrangedSubview(loginButton)
    addSubview(mainStackView)
    
    mainStackView.snp.makeConstraints { make in
      make.center.equalTo(self)
    }
    
    loginButton.addTarget(self, action: #selector(self.loginButtonTapped(_:forEvent:)), for: .touchUpInside)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func loginButtonTapped(_ sender: UIButton,
                                       forEvent event: UIControl.Event) {
    print(event)
    loginPressedPassthrough.send(event)
  }
}
