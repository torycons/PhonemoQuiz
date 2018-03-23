//
//  WordGenerator.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation

struct WordGenerator {
  static func ramdomWord() -> String {
    let randomWord = Int(arc4random_uniform(UInt32(wordList.count)))
    return wordList[randomWord].lowercased()
  }
}
