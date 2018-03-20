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
  
  @IBOutlet weak var modalWrapper: UIView! {
    didSet {
      modalWrapper.layer.cornerRadius = 10
    }
  }
  @IBOutlet weak var nextBtn: UIButton! {
    didSet {
      nextBtn.layer.cornerRadius = 5
    }
  }
  @IBOutlet weak var listenBtn: UIButton! {
    didSet {
      listenBtn.layer.cornerRadius = 5
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(result)
  }
  
  @IBAction func nextQuestion(_ sender: UIButton) {
    dismiss(animated: false, completion: nil)
  }
  
}
