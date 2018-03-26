//
//  ChallengeWord.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation

struct ChallengeWord: Decodable {
  let word: String?
  let ipa: String?
  let audio: String?
}

struct AudioAndIPA: Decodable {
  let audioFile: String?
  let phoneticSpelling: String
}

struct Pronunciation: Decodable {
  let pronunciations: [AudioAndIPA]
}

struct Word: Decodable {
  let word: String
  let lexicalEntries: [Pronunciation]
}

struct SearchResults: Decodable {
  let metadata: [String: String]
  let results: [Word]
}
