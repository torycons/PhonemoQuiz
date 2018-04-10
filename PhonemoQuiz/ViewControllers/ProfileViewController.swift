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
import SDWebImage

class ProfileViewController: UIViewController {
  
  //MARK:- IBOutlet and Variables
  @IBOutlet fileprivate weak var profileWrapper: UIView!
  @IBOutlet fileprivate weak var profileImage: UIImageView!
  @IBOutlet fileprivate weak var profileName: UILabel!
  @IBOutlet fileprivate weak var profileHighScore: UILabel!
  @IBOutlet fileprivate weak var profileLoading: UIActivityIndicatorView!
  @IBOutlet weak var profileStackWrapper: UIStackView!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    fetchProfileData()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchScore()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupUI() {
    profileWrapper.layer.cornerRadius = 7
    profileImage.layer.cornerRadius = profileImage.frame.height/2
    profileLoading.hidesWhenStopped = true
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
  
  //MARK:- Fetch Data Function
  fileprivate func fetchProfileData() {
    UserAPIService.shared.fetchProfileData { (dataJSON) in
      FBSDKService.shared.readDataPicFromFacebook(error: { (alert) in
        self.present(alert, animated: true, completion: nil)
      }, completion: { (pic) in
        let picURL = URL(string: pic!)
        UserAPIService.shared.updatePic(picProfile: pic!)
        DispatchQueue.main.async {
          self.profileImage.sd_setImage(with: picURL, placeholderImage: #imageLiteral(resourceName: "profile"))
          self.profileLoading.stopAnimating()
          self.profileName.text = dataJSON[0]["name"].string
          self.profileStackWrapper.isHidden = false
        }
      })
    }
  }
  
  fileprivate func fetchScore() {
    UserAPIService.shared.fetchProfileData { (dataJSON) in
      guard let highScore = dataJSON[0]["maxScore"].int else { return }
      DispatchQueue.main.async {
        self.profileHighScore.text = "\(highScore)"
      }
    }
  }
}
