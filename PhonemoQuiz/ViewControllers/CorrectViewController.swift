//
//  CorrectViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class CorrectViewController: UIViewController {
  
  var result: String?
  
  @IBOutlet weak var modalWrapper: UIView!
  @IBOutlet weak var nextBtn: UIButton!
  @IBOutlet weak var listenBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  fileprivate func setupUI() {
    modalWrapper.layer.cornerRadius = 10
    nextBtn.layer.cornerRadius = 5
    listenBtn.layer.cornerRadius = 5
  }
  
  @IBAction fileprivate func nextQuestion(_ sender: UIButton) {
    dismiss(animated: false, completion: nil)
  }
  
}
