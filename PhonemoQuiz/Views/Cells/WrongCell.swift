//
//  WrongCell.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class WrongCell: UICollectionViewCell {
  
  @IBOutlet fileprivate weak var listenBtn: UIButton!
  @IBOutlet fileprivate weak var summaryBtn: UIButton!
  @IBOutlet fileprivate weak var background: UIView!
  @IBOutlet fileprivate weak var answerLabel: UILabel!
  
  var score: Int?
  var answer: ChallengeWord? {
    didSet {
      guard let word = answer?.word else { return }
      guard let ipa = answer?.ipa else { return }
      answerLabel.text = "\(word) \(ipa)"
    }
  }
  
  weak var delegate: SwipeCollectionViewDelegate?
  fileprivate var audioPlayer = AVAudioPlayer()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  fileprivate func setupUI () {
    listenBtn.layer.cornerRadius = 5
    summaryBtn.layer.cornerRadius = 5
    background.layer.cornerRadius = 10
  }
  
  @IBAction fileprivate func goToSummary(_ sender: UIButton) {
    self.delegate?.swipeToNext()
    UserAPIService.shared.fetchProfileData { (data) in
      var scoreData = data[0]["scores"].arrayValue.map{ $0.intValue }
      scoreData.append(self.score!)
      UserAPIService.shared.updateScores(scoreData: scoreData)
    }
  }
  
  @IBAction func playAnswerSound(_ sender: UIButton) {
    OxfordAPIService.shared.downloadWordSound(url: answer?.audio) { (data) in
      Audio.shared.setupAudioDownload(audioPlayer: &self.audioPlayer, soundData: data).play()
    }
  }
  
}
