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
  
  //MARK:- IBOutlet and Variables
  @IBOutlet fileprivate weak var profileWrapper: UIView!
  @IBOutlet fileprivate weak var profileImage: UIImageView!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupView()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupUI() {
    profileWrapper.layer.cornerRadius = 7
    profileImage.layer.cornerRadius = profileImage.frame.height/2
  }
  
  fileprivate func setupView() {
    view.addShadowForRoundedButton(view: view, wrapper: profileWrapper, cornerRadius: 5)
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
    } catch {
      Alert.shared.alertResponseOnly(title: "ไม่สามารถออกจากระบบได้", message: "กรุณาลองใหม่", showAlertCompletion: { (alert) in
        self.present(alert, animated: true, completion: nil)
      })
    }
  }
  
  fileprivate func goToLoginPage() {
    let loginStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginScreen")
    self.present(loginStoryBoard, animated: true, completion: nil)
  }
}
