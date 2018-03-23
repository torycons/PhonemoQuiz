//
//  APIService.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
  
  static let shared = APIService()
  
  func fetchWordData(randomWord: String) {
    let url: URLConvertible = "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/\(randomWord)"
    let headers: HTTPHeaders = [
      "Accept": "application/json",
      "app_id": OxfordKeys.appId,
      "app_key": OxfordKeys.appKeys
    ]
    
    Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (dataResponse) in
      if let err = dataResponse.error {
        print(err)
        return
      }
      do {
        let wordResult = try JSONDecoder().decode(SearchResults.self, from: dataResponse.data!)
        let wordData = ChallengeWord(
          word: wordResult.results[0].word,
          ipa: wordResult.results[0].lexicalEntries[0].pronunciations[0].phoneticSpelling,
          audio: wordResult.results[0].lexicalEntries[0].pronunciations[0].audioFile
        )
        print(wordData)
      } catch let decodeErr {
        print(decodeErr)
      }
    }
  }
}
