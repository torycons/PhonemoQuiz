//
//  GameViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 19/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class GameViewController: UIViewController, SFSpeechRecognizerDelegate {
  
  //MARK:- Variables and IBOutlet
  let audioEngine = AVAudioEngine()
  let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
  let request = SFSpeechAudioBufferRecognitionRequest()
  var recognitionTask: SFSpeechRecognitionTask?
  
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
  
  
  @IBAction fileprivate func recordSoundBtnTouch(_ sender: UIButton) {
    audioPlayer.play()
    
    micBtn.buttonAnimateSpring {
      self.micBtn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      self.micBtn.backgroundColor = .red
      self.micBtn.isEnabled = false
      self.micBtn.layer.cornerRadius = self.micBtn.frame.width / 2
    }
    
    recordAndRecognizeSpeech()
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
  
  //MARK: Record and Recognition
  fileprivate func recordAndRecognizeSpeech() {
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)
    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
      self.request.append(buffer)
    }
    audioEngine.prepare()
    do {
      try audioEngine.start()
    } catch {
      self.sendAlert(message: "Audio Engine ทำงานผิดพลาด")
      return print(error)
    }
    
    recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
      if error != nil {
        print(error ?? "")
        return
      }
      
      if let result = result {
        let string = result.bestTranscription.formattedString
        print(string)
        self.cancelRecording()
      }
    })
  }
  
  fileprivate func cancelRecording() {
    request.endAudio()
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionTask?.cancel()
    micBtn.buttonAnimateSpring {
      self.micBtn.transform = .identity
      self.micBtn.backgroundColor = UIColor.orangePhonemo
      self.micBtn.isEnabled = true
      self.micBtn.layer.cornerRadius = 15
    }
  }
  
  fileprivate func sendAlert(message: String) {
    let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
