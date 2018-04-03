//
//  Member.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 3/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation

struct Member {
  var name: String
  var email: String
  var picURL: String
  var maxScore: Int
  var scores: [Int]
  
  init(name: String, email: String, picURL: String, maxScore: Int?, scores: [Int]?) {
    self.name = name
    self.email = email
    self.picURL = picURL
    self.maxScore = maxScore ?? 0
    self.scores = scores ?? []
  }
}
