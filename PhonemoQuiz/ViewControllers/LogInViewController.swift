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
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  
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
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
        guard let mainSB = mainStoryBoard else { return }
        self.present(mainSB, animated: true, completion: nil)
      }
    }
  }
}

