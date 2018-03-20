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
  //MARK: Speech Recognition Variables
  fileprivate let audioEngine = AVAudioEngine()
  fileprivate let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
  fileprivate var request: SFSpeechAudioBufferRecognitionRequest?
  fileprivate var recognitionTask: SFSpeechRecognitionTask?
  
  //MARK: Game Variables
  fileprivate var resultWords = [String]()
  
  //MARK: Effect Sound Variables
  fileprivate let micSound = Bundle.main.url(forResource: "mic", withExtension: "mp3")
  fileprivate let correctSound = Bundle.main.url(forResource: "correct", withExtension: "mp3")
  fileprivate let wrongSound = Bundle.main.url(forResource: "wrong", withExtension: "mp3")
  fileprivate var audioPlayer = AVAudioPlayer()
  
  //MARK: UI Variables
  @IBOutlet fileprivate weak var scoreUser: UILabel!
  @IBOutlet fileprivate weak var question: UILabel!
  @IBOutlet fileprivate weak var micBtn: UIButton! {
    didSet {
      micBtn.layer.cornerRadius = 15
    }
  }
  @IBOutlet fileprivate weak var profilePic: UIImageView! {
    didSet {
      profilePic.layer.cornerRadius = profilePic.frame.height/2
    }
  }
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupStatusBar()
  }
  
  //MARK:- IBActions
  @IBAction fileprivate func quitGame(_ sender: UIButton) {
    let alert = UIAlertController(title: "ออกจากเกม", message: "คุณต้องการออกจากเกมหรือไม่", preferredStyle: .alert)
    let yesBtn = UIAlertAction(title: "ใช่", style: .cancel) { (_) in self.dismiss(animated: true, completion: nil) }
    let noBtn = UIAlertAction(title: "ไม่", style: .default, handler: nil)
    alert.addAction(yesBtn)
    alert.addAction(noBtn)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction fileprivate func recordSoundBtnTouch(_ sender: UIButton) {
    setupAudio(sound: micSound)
    audioPlayer.play()
    
    micBtn.buttonAnimateSpring(animation: {
      self.micBtn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      self.micBtn.backgroundColor = .red
      self.micBtn.isEnabled = false
      self.micBtn.layer.cornerRadius = self.micBtn.frame.width / 2
    }, completion: nil)
    
    recordAndRecognizeSpeech()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupAudio(sound: URL?) {
    guard let sound = sound else { return }
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: sound)
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
    request = SFSpeechAudioBufferRecognitionRequest()
    guard let request = request else { return }
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)
    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
      request.append(buffer)
    }
    audioEngine.prepare()
    do {
      try audioEngine.start()
      self.resultWords = []
    } catch {
      self.sendAlert(message: "Audio Engine ทำงานผิดพลาด")
      return print(error)
    }
    
    recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
      if error != nil {
        print(error ?? "")
        return
      }
      guard let result = result else { return }
      if self.resultWords.count == 0 {
        let stringResult = result.bestTranscription.formattedString
        self.resultWords.append(stringResult)
        self.stopRecording()
      }
    })
  }
  
  fileprivate func stopRecording() {
    request?.endAudio()
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionTask?.cancel()
    micBtn.buttonAnimateSpring(animation: {
      self.micBtn.transform = .identity
      self.micBtn.backgroundColor = UIColor.orangePhonemo
      self.micBtn.isEnabled = true
      self.micBtn.layer.cornerRadius = 15
    }) { (_) in
      self.checkRecordingResult()
    }
  }
  
  //MARK:- Check Recording Result and Push new ViewController
  fileprivate func checkRecordingResult() {
    if !resultWords[0].isEmpty && resultWords[0] == "Hi" {
      pushModal(type: .correct, word: "Hi")
    } else {
      pushModal(type: .wrong, word: "Good")
    }
  }
  
  enum typeModal {
    case correct
    case wrong
  }
  
  fileprivate func pushModal(type: typeModal, word: String) {
    if type == .correct {
      setupAudio(sound: correctSound)
      let viewController = storyboard?.instantiateViewController(withIdentifier: "correct") as! CorrectViewController
      viewController.result = word
      presentVC(viewController: viewController)
    } else if type == .wrong {
      setupAudio(sound: wrongSound)
      let viewController = storyboard?.instantiateViewController(withIdentifier: "wrong") as! WrongViewController
      viewController.result = word
      presentVC(viewController: viewController)
    }
  }
  
  fileprivate func presentVC(viewController: UIViewController) {
    audioPlayer.play()
    viewController.modalPresentationStyle = .overCurrentContext
    present(viewController, animated: false, completion: nil)
  }
  
  //MARK:- Alert Handle Error
  fileprivate func sendAlert(message: String) {
    let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
