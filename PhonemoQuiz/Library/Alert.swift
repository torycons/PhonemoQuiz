//
//  Alert.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class Alert {
  
  static let shared = Alert()
  
  func alertResponseOnly(title: String, message: String, showAlertCompletion: (UIAlertController) -> ()) {
    let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    showAlertCompletion(alert)
  }
}
