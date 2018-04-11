//
//  HighScoreCell.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 19/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class HighScoreCell: UICollectionViewCell {

  var topMemberData: TopScoreLobbyMember? {
    didSet {
      guard let member = topMemberData else { return }
      
      self.numberPlayer.text = "\(member.num)"
      self.scorePlayer.text = "\(member.score)"
      self.namePlayer.text = member.name
      let urlPicture = URL(string: member.pic)
      self.playerPicture.sd_setImage(with: urlPicture, placeholderImage: #imageLiteral(resourceName: "profile"))
      self.delegate?.stopIndicator()
    }
  }
  
  weak var delegate: StopIndicator?
  
  @IBOutlet fileprivate weak var numberPlayer: UILabel!
  @IBOutlet fileprivate weak var namePlayer: UILabel!
  @IBOutlet fileprivate weak var scorePlayer: UILabel!
  @IBOutlet fileprivate weak var playerPicture: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    playerPicture.layer.cornerRadius = playerPicture.frame.height/2
    
  }
}
