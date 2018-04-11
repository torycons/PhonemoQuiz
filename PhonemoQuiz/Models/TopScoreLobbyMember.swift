//
//  TopScoreLobbyMember.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 11/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation

struct TopScoreLobbyMember {
  var num: Int
  var name: String
  var pic: String
  var score: Int
  
  init(num: Int, name: String, pic: String, score: Int) {
    self.num = num
    self.name = name
    self.pic = pic
    self.score = score
  }
}
