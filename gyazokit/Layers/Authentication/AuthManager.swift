//
//  AuthManager.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/3/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Combine
import Foundation
import OAuth2
import UIKit

struct AuthResponse: Decodable {
  var accessToken: String
  var tokenType: String
  var scope: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope
  }
}

class AuthManager: ObservableObject, Authorizable {
  
  private let oauth2 = OAuth2CodeGrant(settings: [
    "client_id": AuthInfo.clientID,
    "client_secret": AuthInfo.clientSecret,
    "authorize_uri": "https://api.gyazo.com/oauth/authorize",
    "token_uri": "https://api.gyazo.com/oauth/token",
    "redirect_uris": [AuthInfo.callbackURL],
    "secret_in_body": true,
    "keychain": false
    ] as OAuth2JSON)
  
  private var loader: OAuth2DataLoader?
  
  private var returnFromAuthCancellable: AnyCancellable?
  
  // MARK: - Init -
  
  init() {
    setupCallbackFromOAuth()
  }
  
  /// Make an `oauth` request against the `gyazo` API. Returns a future that promises to return either the access token (as a nullable string) or no error at all.
  /// - Parameter controller: This controller represents the returning point for `oauth` once the webview handles the user's log in.
  func authorize(in controller: UIViewController?) -> Future<String?, Never> {
    guard let controller = controller else {
      return Future<String?, Never> { seal in
        seal(.success(nil))
      }
    }
        
    let storage = HTTPCookieStorage.shared
    storage.cookies?.forEach() { storage.deleteCookie($0) }
    oauth2.authConfig.authorizeEmbedded = true
    oauth2.authConfig.authorizeContext = controller
    
    
    self.loader = OAuth2DataLoader(oauth2: oauth2)
    
    return Future<String?, Never> { seal in
      
      DispatchQueue.main.async {
        self.oauth2.authorize() { params, error in
          if let params = params, let accessToken = params["access_token"] as? String {
            print(params)
            seal(.success(accessToken))
          }
        }
      }
    }
  }
  
  /// This function is the `callback` from the `SceneDelegate` once the user finishes logging in/cancelling from the safari view presented for logging in.
  private func setupCallbackFromOAuth() {
    self.returnFromAuthCancellable = NotificationCenter.default.publisher(for: .returnFromAuth).sink { notification in
      guard let url = notification.userInfo?["url"] as? URL else { return } // needs error handling
      
      self.oauth2.handleRedirectURL(url)
    }
  }
}
