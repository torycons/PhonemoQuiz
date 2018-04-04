//
//  FBSDKService.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 4/4/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import FBSDKLoginKit
import FirebaseAuth

class FBSDKService {
  
  static let shared = FBSDKService()
  
//  fileprivate func loginFBSDK() {
//    FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
//      if err != nil {
//        Alert.shared.alertResponseOnly(title: "Log In Facebook Error", message: err as! String, showAlertCompletion: { (alert) in
//          self.present(alert, animated: true, completion: nil)
//        })
//        return
//      }
//      self.view.showLoading()
//      self.readDataUser()
//    }
//  }
//  
//  fileprivate func readDataUser() {
//    FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture.type(large)"]).start { (connection, result, err) in
//      if err != nil {
//        Alert.shared.alertResponseOnly(title: "Read User Data Error", message: err as! String, showAlertCompletion: { (alert) in
//          self.present(alert, animated: true, completion: nil)
//        })
//        return
//      }
//      self.loginFirebase(userData: result)
//    }
//  }
//  
//  fileprivate func loginFirebase(userData: Any?) {
//    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//    Auth.auth().signIn(with: credential) { (user, err) in
//      if err != nil {
//        Alert.shared.alertResponseOnly(title: "Log In Firebse Error", message: err as! String, showAlertCompletion: { (alert) in
//          self.present(alert, animated: true, completion: nil)
//        })
//        return
//      }
//      UserAPIService.shared.addDbUser(userData: userData, completion: {
//        self.changeToMainSB()
//      })
//    }
//  }
}
