//
//  LoginViewController_Integration_tests.swift
//  gyazokitTests
//
//  Created by Markim Shaw on 5/6/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import XCTest

@testable import gyazokit

final class MockAuthManager: Authorizable {
  private var _accessToken: String?
  
  var expectation: XCTestExpectation?
  
  func authorize(in controller: UIViewController?) -> Future<String?, Never> {
    return Future<String?, Never> { seal in
      self._accessToken = "Finished"
      seal(.success(self._accessToken))
      self.expectation?.fulfill()
      self.expectation = nil
    }
  }
  
  func setAccessToken(_ value: String?) {
    _accessToken = value
  }
  
  func getAccessToken() -> String? {
    return _accessToken
  }
}

final class MockKeychainManager: AnySecret<PasswordKey, String> {
  private var _savedItem: String?
  
  override func save(key: PasswordKey, value: String?) {
    _savedItem = value
  }
  
  override func retrieve(key: PasswordKey) -> String? { return _savedItem }
}

class LoginViewController_Integration_tests: XCTestCase {
  
  // MARK: - Subscribers -
  var loginButtonPress: PassthroughSubject<UIButton, Never>!
  var mockAuthManager: Authorizable!
  var mockKeychainManager: AnySecret<PasswordKey, String>!
  
  var sut_view: LoginView!
  var sut: LoginViewController!
  
  override func setUp() {
    super.setUp()
    
    loginButtonPress = PassthroughSubject<UIButton, Never>()
    mockAuthManager = MockAuthManager()
    mockKeychainManager = MockKeychainManager()
    
    sut_view = LoginView()
    sut_view.loginPressedPassthrough = loginButtonPress
    
    sut = LoginViewController(view: sut_view,
                              authManager: mockAuthManager,
                              secrets: mockKeychainManager)
    
    _ = sut.view
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    loginButtonPress = nil
    mockAuthManager = nil
    mockKeychainManager = nil
    
    sut_view = nil
    sut = nil
    
    super.tearDown()
  }
  
  // MARK: - Tests -
  
  func testLoginButtonPressed() {
    // Given: -
    
    (mockAuthManager as? MockAuthManager)?.expectation = expectation(description: "Waiting for button press")
    
    // When: - Login button is pressed
    loginButtonPress.send(UIButton())
    
    waitForExpectations(timeout: 10.0) { _ in
      // Then: - Data is saved to keychain
      let expectedAccessToken = (self.mockAuthManager as? MockAuthManager)?.getAccessToken()
      let accessToken = self.mockKeychainManager.retrieve(key: .accessToken)
      
      XCTAssertNotNil(expectedAccessToken)
      XCTAssertNotNil(accessToken)
      XCTAssertEqual(accessToken, expectedAccessToken)
    }
  }
}
