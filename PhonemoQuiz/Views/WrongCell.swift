//
//  WrongCell.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class WrongCell: UICollectionViewCell {
  
  @IBOutlet weak var listenBtn: UIButton!
  @IBOutlet weak var summaryBtn: UIButton!
  @IBOutlet weak var background: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    listenBtn.layer.cornerRadius = 5
    summaryBtn.layer.cornerRadius = 5
    background.layer.cornerRadius = 10
  }
  
  @IBAction func goToSummary(_ sender: UIButton) {
    
  }
  
  
}
