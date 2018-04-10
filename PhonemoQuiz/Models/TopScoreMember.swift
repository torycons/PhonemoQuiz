//
//  TopScore.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 10/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation

struct TopScoreMember {
  var uid: String
  var score: Int
  
  init(uid: String, score: Int) {
    self.uid = uid
    self.score = score
  }
}
