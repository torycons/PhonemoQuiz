//
//  ProfileViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UICollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction fileprivate func LogoutBtn(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      goToLoginPage()
    } catch let signOutError as NSError {
      print("Can't Log out", signOutError)
    }
  }
  
  fileprivate func goToLoginPage() {
    let loginStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginScreen")
    self.present(loginStoryBoard, animated: true, completion: nil)
  }
}
