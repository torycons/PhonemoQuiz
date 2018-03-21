//
//  WrongViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class WrongViewController: UIViewController, SwipeCollectionViewDelegate, DismissViewDelegate {

  var result: String?
  weak var delegate: DismissViewDelegate?
  fileprivate let scoreId = "score"
  fileprivate let summaryId = "summary"
  @IBOutlet fileprivate weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    print(result)
  }
  
  fileprivate func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(WrongCell.self, forCellWithReuseIdentifier: scoreId)
    collectionView.register(UINib(nibName: "WrongCell", bundle: nil), forCellWithReuseIdentifier: scoreId)
    collectionView.register(SummaryCell.self, forCellWithReuseIdentifier: summaryId)
    collectionView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellWithReuseIdentifier: summaryId)
  }
  
  func swipeToNext() {
    let indexPath = IndexPath(item: 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
  }
  
  func viewDismiss() {
    self.dismiss(animated: false) {
      self.delegate?.viewDismiss()
    }
  }
}

extension WrongViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0:
      let wrongCell = collectionView.dequeueReusableCell(withReuseIdentifier: scoreId, for: indexPath) as! WrongCell
      wrongCell.delegate = self
      return wrongCell
    case 1:
      let summaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryId, for: indexPath) as! SummaryCell
      summaryCell.delegate = self
      return summaryCell
    default:
      let cell = UICollectionViewCell()
      return cell
    }
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
  }
}

