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
  
  //MARK:- IBOutlet
  @IBOutlet fileprivate weak var loginBtn: UIButton!
  
  //MARK:- View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  //MARK:- Setup UI Function
  fileprivate func setupUI() {
    loginBtn.layer.cornerRadius = 5
  }
  
  //MARK:- Log in Facebook Functions
  @IBAction fileprivate func LoginFacebook(_ sender: UIButton) {
    loginFBSDK()
  }
  
  fileprivate func loginFBSDK() {
    FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
      if err != nil {
        Alert.shared.alertResponseOnly(title: "Log In Facebook Error", message: err as! String, showAlertCompletion: { (alert) in
          self.present(alert, animated: true, completion: nil)
        })
        return
      }
      self.view.showLoading()
      self.readDataUser()
    }
  }
  
  fileprivate func readDataUser() {
    FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
      if err != nil {
        Alert.shared.alertResponseOnly(title: "Read User Data Error", message: err as! String, showAlertCompletion: { (alert) in
          self.present(alert, animated: true, completion: nil)
        })
        return
      }
      self.loginFirebase(userData: result)
    }
  }
  
  fileprivate func loginFirebase(userData: Any?) {
    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
    Auth.auth().signIn(with: credential) { (user, err) in
      if err != nil {
        Alert.shared.alertResponseOnly(title: "Log In Firebse Error", message: err as! String, showAlertCompletion: { (alert) in
          self.present(alert, animated: true, completion: nil)
        })
        return
      }
      UserAPIService.shared.addDbUser(userData: userData, completion: {
        self.changeToMainSB()
      })
    }
  }

  fileprivate func changeToMainSB() {
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    guard let mainSB = mainStoryBoard else { return }
    self.view.hideLoading()
    self.present(mainSB, animated: true, completion: nil)
  }
}

