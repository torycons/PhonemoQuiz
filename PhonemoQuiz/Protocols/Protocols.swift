//
//  Protocols.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 21/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

protocol SwipeCollectionViewDelegate: class {
  func swipeToNext()
}

protocol DismissViewDelegate: class {
  func viewDismiss()
}

protocol FetchDataDelegate: class {
  func fetchNewWord()
}

protocol StopIndicator: class {
  func stopIndicator()
}
