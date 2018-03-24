//
//  SummaryCell.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class SummaryCell: UICollectionViewCell {
  
  var score: Int? {
    didSet {
      guard let score = score else { return }
      userScore.text = "\(score)"
    }
  }
  
  @IBOutlet fileprivate weak var backToLobby: UIButton!
  @IBOutlet weak var userScore: UILabel!
  weak var delegate: DismissViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  fileprivate func setupUI() {
    self.layer.cornerRadius = 10
    backToLobby.layer.cornerRadius = 5
  }
  
  @IBAction func backToLobby(_ sender: UIButton) {
    self.delegate?.viewDismiss()
  }
  
}
