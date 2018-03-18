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
import SVProgressHUD

class LogInViewController: UIViewController {
  
  @IBOutlet fileprivate weak var loginBtn: UIButton! {
    didSet {
      loginBtn.layer.cornerRadius = 5
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK:- Log in Facebook Functions
  @IBAction fileprivate func LoginFacebook(_ sender: UIButton) {
    loginFBSDK()
  }
  
  fileprivate func loginFBSDK() {
    FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
      if err != nil {
        print(err ?? "")
        return
      }
      self.view.showLoading()
      self.readEmail()
    }
  }
  
  fileprivate func readEmail() {
    FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture.type(large)"]).start { (connection, result, error) in
      if error != nil {
        print(error ?? "")
        return
      }
      print(result ?? "")
      self.loginFirebase()
    }
  }
  
  fileprivate func loginFirebase() {
    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
    Auth.auth().signIn(with: credential) { (user, err) in
      if err != nil {
        print(err ?? "")
        return
      }
      self.changeToMainSB()
    }
  }

  fileprivate func changeToMainSB() {
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    guard let mainSB = mainStoryBoard else { return }
    self.present(mainSB, animated: true, completion: nil)
    SVProgressHUD.dismiss()
  }
}

