//
//  WrongViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class WrongViewController: UIViewController {
  
  var result: String?
  fileprivate let scoreCell = "score"
  fileprivate let summaryCell = "summary"
  @IBOutlet fileprivate weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollectionView()
  }
  
  fileprivate func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(WrongCell.self, forCellWithReuseIdentifier: scoreCell)
    collectionView.register(UINib(nibName: "WrongCell", bundle: nil), forCellWithReuseIdentifier: scoreCell)
    collectionView.register(SummaryCell.self, forCellWithReuseIdentifier: summaryCell)
    collectionView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellWithReuseIdentifier: summaryCell)
  }
  
}

extension WrongViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell = UICollectionViewCell()
    if indexPath.item == 0 {
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: scoreCell, for: indexPath) as! WrongCell
    }
    
    if indexPath.item == 1 {
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryCell, for: indexPath) as! SummaryCell
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenSize = UIScreen.main.bounds.size.width
    switch(screenSize){
    case 414:
      return CGSize(width:  334, height: 360)
    case 375:
      return CGSize(width: 295, height: 360)
    case 320:
      return CGSize(width: 260, height: 360)
    default:
      return CGSize(width: 260, height: 360)
    }
  }
}

