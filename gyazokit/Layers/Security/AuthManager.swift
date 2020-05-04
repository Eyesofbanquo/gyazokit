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

class AuthManager: ObservableObject {
  
  let oauth2 = OAuth2CodeGrant(settings: [
    "client_id": AuthInfo.clientID,
    "client_secret": AuthInfo.clientSecret,
    "authorize_uri": "https://api.gyazo.com/oauth/authorize",
    "token_uri": "https://api.gyazo.com/oauth/token",
    "redirect_uris": [AuthInfo.callbackURL],
    "secret_in_body": true,
    "keychain": false
    ] as OAuth2JSON)
  
  var loader: OAuth2DataLoader?
  
  let controller = UIViewController()
  
  func authorize(in controller: UIViewController?) -> Future<Bool, Never> {
    guard let controller = controller else {
      return Future<Bool, Never> { seal in
        seal(.success(false))
      }
    }
    
    oauth2.authConfig.authorizeEmbedded = true
    oauth2.authConfig.authorizeContext = controller
    
    self.loader = OAuth2DataLoader(oauth2: oauth2)
    
    return Future<Bool, Never> { seal in
      
      DispatchQueue.main.async {
        self.oauth2.authorize() { params, error in
          if let params = params, let accessToken = params["access_token"] as? String {
//            Secure.keychain["access_token"] = accessToken
            print(params)
            seal(.success(true))
          }
        }
      }
    }
  }
}
