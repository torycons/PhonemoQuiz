//
//  CorrectViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import AVFoundation

class CorrectViewController: UIViewController {

  //MARK:- Variables and IBOutlet
  weak var delegate: FetchDataDelegate?
  var answer: ChallengeWord?
  fileprivate var audioPlayer = AVAudioPlayer()
  
  @IBOutlet weak var modalWrapper: UIView!
  @IBOutlet weak var nextBtn: UIButton!
  @IBOutlet weak var listenBtn: UIButton!
  @IBOutlet weak var answerLabel: UILabel!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupAnswer()
    Audio.shared.useAllSpeaker()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupUI() {
    modalWrapper.layer.cornerRadius = 10
    nextBtn.layer.cornerRadius = 5
    listenBtn.layer.cornerRadius = 5
  }
  
  fileprivate func setupAnswer() {
    guard let word = answer?.word else { return }
    guard let ipa = answer?.ipa else { return }
    answerLabel.text = "\(word) \(ipa)"
  }
  
  //MARK:- IBActions
  @IBAction fileprivate func nextQuestion(_ sender: UIButton) {
    dismiss(animated: false, completion: nil)
    self.delegate?.fetchNewWord()
  }
  
  @IBAction func playAnswerSound(_ sender: UIButton) {
    OxfordAPIService.shared.downloadWordSound(url: answer?.audio) { (data) in
      Audio.shared.setupAudioDownload(audioPlayer: &self.audioPlayer, soundData: data).play()
    }
  }
}
