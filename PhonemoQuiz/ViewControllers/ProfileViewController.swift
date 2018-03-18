//
//  ProfileViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var profileWrapper: UIView! {
    didSet {
      profileWrapper.layer.cornerRadius = 7
    }
  }
  
  @IBOutlet weak var profileImage: UIImageView! {
    didSet {
      profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
  }
  
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  //MARK:- Logout Functions
  @IBAction fileprivate func LogoutBtn(_ sender: UIBarButtonItem) {
    let logoutAlert = UIAlertController(title: "ออกจากระบบ", message: "คุณต้องการออกจากระบบหรือไม่", preferredStyle: .alert)
    let logOutBtn = UIAlertAction(title: "ตกลง", style: .cancel) { (_) in self.logOut() }
    let cancleButton = UIAlertAction(title: "ยกเลิก", style: .default, handler: nil)
    logoutAlert.addAction(cancleButton)
    logoutAlert.addAction(logOutBtn)
    
    present(logoutAlert, animated: true, completion: nil)
  }
  
  fileprivate func logOut() {
    do {
      try Auth.auth().signOut()
      FBSDKLoginManager().logOut()
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
