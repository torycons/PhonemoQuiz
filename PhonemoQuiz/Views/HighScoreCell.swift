//
//  HighScoreCell.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 19/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class HighScoreCell: UICollectionViewCell {

  @IBOutlet weak var numberPlayer: UILabel!
  @IBOutlet weak var namePlayer: UILabel!
  @IBOutlet weak var scorePlayer: UILabel!
  @IBOutlet weak var playerPicture: UIImageView! {
    didSet {
      playerPicture.layer.cornerRadius = playerPicture.frame.height/2
    }
  }
}
