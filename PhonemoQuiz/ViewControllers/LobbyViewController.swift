//
//  LobbyViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class LobbyViewController: UIViewController {
  
  //MARK:- IBOutlet
  @IBOutlet weak var highScoreCollectionView: UICollectionView!
  
  @IBOutlet weak var highScoreWrapper: UIView! {
    didSet {
      highScoreWrapper.layer.cornerRadius = 7
    }
  }
  
  @IBOutlet weak var startGameWrapper: UIView! {
    didSet {
      startGameWrapper.layer.cornerRadius = 7
    }
  }
  
  @IBOutlet weak var startBtn: UIButton! {
    didSet {
      startBtn.layer.cornerRadius = 5
    }
  }
  
  //MARK:- Variables
  fileprivate let cellId = "CellID"
  
  //MARK:- Life Cycle View
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    highScoreWrapper.addShadowForRoundedButton(view: view, wrapper: highScoreWrapper, cornerRadius: 7)
    startGameWrapper.addShadowForRoundedButton(view: view, wrapper: startGameWrapper, cornerRadius: 7)
  }
  
  //MARK:- Setup Functions
  fileprivate func setupCollectionView() {
    highScoreCollectionView.delegate = self
    highScoreCollectionView.dataSource = self
    highScoreCollectionView.register(HighScoreCell.self, forCellWithReuseIdentifier: cellId)
    highScoreCollectionView.register(UINib(nibName: "HighScoreCell", bundle: nil), forCellWithReuseIdentifier: cellId)
  }
  
  
}

extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  //MARK:- CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = highScoreCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HighScoreCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenSize = UIScreen.main.bounds.size.width
    switch(screenSize){
    case 414:
      return CGSize(width:  300, height: 43)
    case 375:
      return CGSize(width: 255, height: 37)
    case 320:
      return CGSize(width: 200, height: 35)
    default:
      return CGSize(width: 250, height: 40)
    }
  }
  
}



