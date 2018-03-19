//
//  GameViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 19/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
  
  //MARK:- Variables and IBOutlet
  var micSound = Bundle.main.url(forResource: "mic", withExtension: "mp3")
  var audioPlayer = AVAudioPlayer()
  
  @IBOutlet weak var micBtn: UIButton! {
    didSet {
      micBtn.layer.cornerRadius = 15
    }
  }
  
  @IBOutlet weak var profilePic: UIImageView! {
    didSet {
      profilePic.layer.cornerRadius = profilePic.frame.height/2
    }
  }
  
  @IBOutlet weak var scoreUser: UILabel!
  @IBOutlet weak var question: UILabel!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupStatusBar()
    setupAudio()
  }
  
  //MARK:- IBActions and Functions
  @IBAction fileprivate func quitGame(_ sender: UIButton) {
    let alert = UIAlertController(title: "ออกจากเกม", message: "คุณต้องการออกจากเกมหรือไม่", preferredStyle: .alert)
    let yesBtn = UIAlertAction(title: "ใช่", style: .cancel) { (_) in self.dismiss(animated: true, completion: nil) }
    let noBtn = UIAlertAction(title: "ไม่", style: .default, handler: nil)
    alert.addAction(yesBtn)
    alert.addAction(noBtn)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction fileprivate func recordSound(_ sender: UIButton) {
    audioPlayer.play()
  }
  
  fileprivate func setupAudio() {
    guard let micSound = micSound else { return }
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: micSound)
      audioPlayer.prepareToPlay()
    } catch {
      print("Error: Can't play button sound")
    }
  }
  
  fileprivate func setupStatusBar() {
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    statusBarView.backgroundColor = UIColor.orangePhonemo
    view.addSubview(statusBarView)
  }
  
}
