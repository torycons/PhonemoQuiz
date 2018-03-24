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

class GameViewController: UIViewController, SFSpeechRecognizerDelegate, DismissViewDelegate {
  
  //MARK:- Variables and IBOutlet
  //MARK: Speech Recognition Variables
  fileprivate let audioEngine = AVAudioEngine()
  fileprivate let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
  fileprivate var request: SFSpeechAudioBufferRecognitionRequest?
  fileprivate var recognitionTask: SFSpeechRecognitionTask?
  
  //MARK: Game Variables
  fileprivate let randomWord = WordGenerator.shared.ramdomWord()
  fileprivate var resultWords = [String]()
  fileprivate var score = 0 {
    didSet {
      scoreUser.text = "Score: \(score)"
    }
  }
  
  //MARK: Sound  Variables
  fileprivate let micSound = Bundle.main.url(forResource: "mic", withExtension: "mp3")
  fileprivate let correctSound = Bundle.main.url(forResource: "correct", withExtension: "mp3")
  fileprivate let wrongSound = Bundle.main.url(forResource: "wrong", withExtension: "mp3")
  fileprivate var audioPlayer = AVAudioPlayer()
  
  //MARK: UI Variables
  @IBOutlet fileprivate weak var scoreUser: UILabel!
  @IBOutlet fileprivate weak var questionLabel: UILabel!
  @IBOutlet fileprivate weak var micBtn: UIButton!
  @IBOutlet fileprivate weak var profilePic: UIImageView!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.showLoading()
    view.setupStatusBar(view: view)
    print(randomWord)
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchWordData(word: randomWord)
  }
  
  //MARK:- IBActions
  @IBAction fileprivate func quitGame(_ sender: UIButton) {
    let alert = UIAlertController(title: "ออกจากเกม", message: "คุณต้องการออกจากเกมหรือไม่  (คะแนนจะไม่ถูกบันทึก)", preferredStyle: .alert)
    let yesBtn = UIAlertAction(title: "ใช่", style: .cancel) { (_) in self.dismiss(animated: true, completion: nil) }
    let noBtn = UIAlertAction(title: "ไม่", style: .default, handler: nil)
    alert.addAction(yesBtn)
    alert.addAction(noBtn)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction fileprivate func recordSoundBtnTouch(_ sender: UIButton) {
    Audio.shared.setupAudio(audioPlayer: &audioPlayer, sound: micSound).play()
    micBtn.buttonAnimateSpring(animation: {
      self.micBtn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      self.micBtn.backgroundColor = .red
      self.micBtn.isEnabled = false
      self.micBtn.layer.cornerRadius = self.micBtn.frame.width / 2
    },completion: { (_) in
      self.recordAndRecognizeSpeech()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        print(self.resultWords)
        self.stopRecording()
      })
    })
  }
  
  //MARK:- Call APIs Functions
  func fetchWordData(word: String) {
    APIService.shared.fetchWordData(randomWord: word) { (result) in
      guard let ipa = result.ipa else { return }
      self.questionLabel.text = ipa
      self.view.hideLoading()
    }
  }
  
  //MARK:- Delegate Functions
  func viewDismiss() {
    self.dismiss(animated: true, completion: nil)
  }
  
  //MARK:- Setup Functions
  fileprivate func setupUI() {
    micBtn.layer.cornerRadius = 15
    profilePic.layer.cornerRadius = profilePic.frame.height/2
  }
  
  fileprivate func btnAnimBack() {
    self.micBtn.buttonAnimateSpring(animation: {
      self.micBtn.transform = .identity
      self.micBtn.backgroundColor = UIColor.orangePhonemo
      self.micBtn.isEnabled = true
      self.micBtn.layer.cornerRadius = 15
    }) { (_) in
      self.checkRecordingResult()
    }
  }
  
  //MARK: Record and Recognition
  fileprivate func recordAndRecognizeSpeech() {
    WordRecognition.shared.recordSpeech(request: &request, audioEngine: audioEngine) { (audioEngine, request)  in
      do {
        try audioEngine.start()
        self.resultWords = []
      } catch {
        self.sendAlert(message: "Audio Engine ทำงานผิดพลาด")
        return print(error)
      }
      
      WordRecognition.shared.recognitionTask(recognitionTask: &recognitionTask, speechRecognizer: speechRecognizer, request: request, completion: { (result) in
        guard let result = result else { return }
        let stringResult = result.bestTranscription.formattedString
        self.resultWords.append(stringResult)
      })
    }
  }
  
  fileprivate func stopRecording() {
    WordRecognition.shared.stopRecording(request: request, audioEngine: audioEngine, recognitionTask: &self.recognitionTask, completion: {
      self.btnAnimBack()
    })
  }
  
  //MARK:- Check Recording Result and Push new ViewController
  fileprivate func checkRecordingResult() {
    if !resultWords[0].isEmpty && resultWords[0] == "Hi" {
      score += 50
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
      let viewController = storyboard?.instantiateViewController(withIdentifier: "correct") as! CorrectViewController
      viewController.result = word
      presentVC(viewController: viewController, audioPlayer: Audio.shared.setupAudio(audioPlayer: &audioPlayer, sound: correctSound))
    } else if type == .wrong {
      let viewController = storyboard?.instantiateViewController(withIdentifier: "wrong") as! WrongViewController
      viewController.delegate = self
      viewController.score = self.score
      presentVC(viewController: viewController, audioPlayer: Audio.shared.setupAudio(audioPlayer: &audioPlayer, sound: wrongSound))
    }
  }
  
  fileprivate func presentVC(viewController: UIViewController, audioPlayer: AVAudioPlayer) {
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
