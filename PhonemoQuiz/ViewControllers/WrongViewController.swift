//
//  WrongViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 20/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftyJSON

class WrongViewController: UIViewController, SwipeCollectionViewDelegate, DismissViewDelegate {

  //MARK:- Variables and IBOutlet
  var score: Int?
  var answer: ChallengeWord?
  weak var delegate: DismissViewDelegate?
  
  fileprivate let scoreId = "score"
  fileprivate let summaryId = "summary"
  
  fileprivate let db = Firestore.firestore()
  
  @IBOutlet fileprivate weak var collectionView: UICollectionView!
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    Audio.shared.useAllSpeaker()
    saveGameScore()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(WrongCell.self, forCellWithReuseIdentifier: scoreId)
    collectionView.register(UINib(nibName: "WrongCell", bundle: nil), forCellWithReuseIdentifier: scoreId)
    collectionView.register(SummaryCell.self, forCellWithReuseIdentifier: summaryId)
    collectionView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellWithReuseIdentifier: summaryId)
  }
  
  //MARK:- Delegate Functions
  func swipeToNext() {
    let indexPath = IndexPath(item: 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
  }
  
  func viewDismiss() {
    self.dismiss(animated: false) {
      self.delegate?.viewDismiss()
    }
  }
  
  //MARK:- Save Scores to DB
  fileprivate func saveGameScore() {
    let auth = Auth.auth().currentUser?.uid
    db.collection("Members").document(auth!).getDocument { (document, err) in
      guard let unwrapDocument = document?.data() else { return }
      let documentJSON = JSON(arrayLiteral: unwrapDocument)
      let oldHighScore = documentJSON[0]["maxScore"].int
      
      if self.score! > oldHighScore! {
        self.db.collection("Members").document(auth!).updateData(["maxScore" : self.score!])
      }
      
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
      wrongCell.answer = answer
      return wrongCell
    case 1:
      let summaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryId, for: indexPath) as! SummaryCell
      summaryCell.delegate = self
      summaryCell.score = score
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

