//
//  ViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LogInViewController: UIViewController {
  

  @IBOutlet weak var loginBtn: UIButton! {
    didSet {
      loginBtn.layer.cornerRadius = 5
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
//    let loginButton = FBSDKLoginButton()
//    view.addSubview(loginButton)
//    loginButton.readPermissions = ["email", "public_profile"]
//    loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
//    loginButton.delegate = self
    
  }
  
//  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//    print("Log out From facebook")
//  }
//
//  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//    if error != nil {
//      print(error.localizedDescription)
//      return
//    }
//
//    print("Successfully log in with facebook")
//    FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
//      if error != nil {
//        print(error)
//        return
//      }
//
//      print(result)
//    }
//  }
  
  
  @IBAction func LoginFacebook(_ sender: UIButton) {
    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
    Auth.auth().signIn(with: credential) { (user, err) in
      if err != nil {
        print(err ?? "")
        return
      }
      print(user?.uid ?? "")
    }
    
    FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
      if err != nil {
        print(err ?? "")
        return
      }
      FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
        if error != nil {
          print(error ?? "")
          return
        }
        print(result ?? "")
        
        self.performSegue(withIdentifier: "mainPage", sender: nil)
      }
    }
  }
}

