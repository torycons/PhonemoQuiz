//
//  APIService.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Foundation
import Alamofire

enum fetchWordError: Error {
  case noDataFetch
  case error
}

class APIService {
  
  static let shared = APIService()
  
  func fetchWordData(randomWord: String, completion: @escaping (ChallengeWord) -> Void, completion404: @escaping () -> ()) {
    let url: URLConvertible = "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/\(randomWord)"
    let headers: HTTPHeaders = [
      "Accept": "application/json",
      "app_id": OxfordKeys.appId,
      "app_key": OxfordKeys.appKeys
    ]
    
    Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (dataResponse) in
      if dataResponse.response?.statusCode == 404 {
        completion404()
        return
      }
      if let err = dataResponse.error {
        print("Error: \(err)")
        return
      }
      do {
        let wordResult = try JSONDecoder().decode(SearchResults.self, from: dataResponse.data!)
        var wordDatas: [ChallengeWord] = []
        wordResult.results[0].lexicalEntries[0].pronunciations.forEach({ (data) in
          if data.audioFile != nil {
            let wordData = ChallengeWord(
              word: wordResult.results[0].word,
              ipa: data.phoneticSpelling,
              audio: data.audioFile
            )
            wordDatas.append(wordData)
          }
        })
        completion(wordDatas[0])
      } catch let decodeErr {
        print(decodeErr)
      }
    }
  }
  
  func downloadWordSound(url: String?, completion: @escaping (Data?) -> Void) {
    guard let unwrapUrl = url else { return }
    let url: URLConvertible = unwrapUrl
    
    Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (dataResponse) in
      let data = dataResponse.data
      completion(data)
    }
  }
  
}
