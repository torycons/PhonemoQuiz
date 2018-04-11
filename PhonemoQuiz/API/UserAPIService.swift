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
          "picurl": userDataJSON[0]["picture"]["data"]["url"].string ?? "",
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
  
  func updateScores(scoreData: [Int], completion: @escaping () -> Void) {
    self.fetchProfileData { (data) in
      let oldMaxScore = Int(truncating: data[0]["maxScore"].numberValue)
      let lastestScore = scoreData[scoreData.endIndex - 1]
      if lastestScore > oldMaxScore {
        self.db.collection("Members").document(self.uid!).updateData(["maxScore": lastestScore])
      }
    }
    
    db.collection("Members").document(uid!).updateData(["scores": scoreData]) { (_) in
      completion()
    }
  }
  
  func updatePic(picProfile: String) {
    db.collection("Members").document(uid!).updateData(["picurl": picProfile], completion: nil)
  }
  
  func updateTopScoreToDB(score: Int?) {
    self.db.collection("Lobby").document("Users").getDocument(completion: { (document, err) in
      guard let unwrapData = document?.data() else { return }
      let dataJSON = JSON(arrayLiteral: unwrapData)
      var topScoreUsers = dataJSON[0]["TopScore"].map({ (user) -> TopScoreMember in
        return TopScoreMember(uid: user.1["uid"].stringValue, score: Int(truncating: user.1["score"].numberValue))
      })
      for topMember in topScoreUsers {
        guard let userScore = score else { return }
        if (userScore > topMember.score) {
          let user = TopScoreMember(uid: (Auth.auth().currentUser?.uid)!, score: userScore)
          topScoreUsers.append(user)
          break
        }
      }
      let sortedMember = topScoreUsers.sorted(by: { $0.score > $1.score })
      let totalArray: [TopScoreMember] = sortedMember.count > 5 ? Array(sortedMember[0...4]) : sortedMember
      let userType = totalArray.map({ (member) -> [String: Any] in
        return ["score": member.score, "uid": member.uid]
      })
      self.db.collection("Lobby").document("Users").updateData(["TopScore": userType])
    })
  }
}
