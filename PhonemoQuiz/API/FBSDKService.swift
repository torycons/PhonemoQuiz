//
//  FBSDKService.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 4/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import FBSDKLoginKit
import FirebaseAuth
import SwiftyJSON

class FBSDKService {
  
  static let shared = FBSDKService()
  
  func readDataPicFromFacebook(error: @escaping (UIAlertController) -> Void , completion: @escaping (String?) -> Void) {
    FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture.type(large)"]).start { (connection, result, err) in
      if err != nil {
        Alert.shared.alertResponseOnly(title: "Read User Data Error", message: err as! String, showAlertCompletion: { (alert) in
          error(alert)
        })
        return
      }
      let userDataJSON = JSON(arrayLiteral: result!)
      let pic = userDataJSON[0]["picture"]["data"]["url"].string
      completion(pic)
    }
  }
}
