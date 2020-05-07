//
//  Confidante.swift
//  gyazokit
//
//  Created by Markim Shaw on 5/5/20.
//  Copyright © 2020 Markim Shaw. All rights reserved.
//

import Foundation

struct Confidante<T: Secret> {
  var secret: some Secret = T.init()
}

class AnySecret<Key, Value>: Secret {
  typealias Key = Key
  
  typealias Val = Value
  
  required init() {
    
  }
  
  func save(key: Key, value: Value?) { }
  
  func retrieve(key: Key) -> Value? { return nil }
  
}

protocol Secret {
  
  associatedtype Key
  associatedtype Val
  
  init()
  
  func save(key: Key, value: Val?)
  
  func retrieve(key: Key) -> Val?
}
