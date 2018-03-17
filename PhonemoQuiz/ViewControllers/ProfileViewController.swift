//
//  ProfileViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction func LogoutBtn(_ sender: UIBarButtonItem) {
    do {
      try? Auth.auth().signOut()
    } catch {
      print("Can't Log out")
    }
    
    let loginStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginScreen")
    self.present(loginStoryBoard, animated: true, completion: nil)
  }
}
