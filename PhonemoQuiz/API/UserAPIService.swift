//
//  UserAPIService.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 3/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Firebase
import SwiftyJSON

class UserAPIService {
  
  static let shared = UserAPIService()
  
  fileprivate let db = Firestore.firestore()
  fileprivate let uid = Auth.auth().currentUser?.uid
  
  func addDbUser(userData: Any?, completion: @escaping () -> ()) {
    db.collection("Members").document(uid!).getDocument { (document, err) in
      guard (document?.data()) != nil else {
        let userData = userData as! [String: Any]
        let userDataJSON = JSON(arrayLiteral: userData)
        self.db.collection("Members").document(self.uid!).setData([
          "name": userDataJSON[0]["name"].string ?? "",
          "email": userDataJSON[0]["email"].string ?? "",
          "maxScore": 0,
          "scores": []
          ], completion: { (_) in
            completion()
        })
        return
      }
      completion()
    }
  }
  
  func fetchProfileData(completion: @escaping (JSON) -> Void) {
    db.collection("Members").document(uid!).getDocument { (document, err) in
      guard let unwrapData = document?.data() else { return }
      let dataJSON = JSON(arrayLiteral: unwrapData)
      
      completion(dataJSON)
    }
  }
  
  func updateScores(scoreData: [Int]) {
    db.collection("Members").document(uid!).updateData(["scores": scoreData])
  }
}
