//
//  LobbyViewController.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 17/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftyJSON

class LobbyViewController: UIViewController, StopIndicator {

  //MARK:- IBOutlet
  @IBOutlet weak var highScoreCollectionView: UICollectionView!
  @IBOutlet weak var topScoreLoadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var highScoreWrapper: UIView!
  @IBOutlet weak var startGameWrapper: UIView!
  @IBOutlet weak var startBtn: UIButton!
  
  //MARK:- Variables
  fileprivate let cellId = "CellID"
  fileprivate var topMember: [JSON]?
  
  //MARK:- Life Cycle View
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupUI()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    highScoreWrapper.addShadowForRoundedButton(view: view, wrapper: highScoreWrapper, cornerRadius: 7)
    startGameWrapper.addShadowForRoundedButton(view: view, wrapper: startGameWrapper, cornerRadius: 7)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setupLoading()
    fetchTopScoreData()
  }
  
  //MARK:- Setup Functions
  fileprivate func setupUI() {
    highScoreWrapper.layer.cornerRadius = 7
    startGameWrapper.layer.cornerRadius = 7
    startBtn.layer.cornerRadius = 5
  }
  
  fileprivate func setupCollectionView() {
    highScoreCollectionView.delegate = self
    highScoreCollectionView.dataSource = self
    highScoreCollectionView.register(HighScoreCell.self, forCellWithReuseIdentifier: cellId)
    highScoreCollectionView.register(UINib(nibName: "HighScoreCell", bundle: nil), forCellWithReuseIdentifier: cellId)
  }
  
  fileprivate func fetchTopScoreData() {
    UserAPIService.shared.fetchTopMember { (data) in
      let topScoreArray = data[0]["TopScore"].arrayValue
      self.topMember = topScoreArray
      
      DispatchQueue.main.async {
        self.highScoreCollectionView.reloadData()
      }
    }
  }
  
  fileprivate func setupLoading() {
    highScoreCollectionView.isHidden = true
    topScoreLoadingIndicator.hidesWhenStopped = true
    topScoreLoadingIndicator.startAnimating()
  }
  
  //MARK:- Delegate Function
  func stopIndicator() {
    self.topScoreLoadingIndicator.stopAnimating()
    self.highScoreCollectionView.isHidden = false
  }
}

extension LobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = highScoreCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HighScoreCell
    if let member = self.topMember {
      UserAPIService.shared.fetchOtherProfileData(uid: member[indexPath.item]["uid"].stringValue) { (data) in
        let memberData = TopScoreLobbyMember(
          num: indexPath.item + 1,
          name: data[0]["name"].stringValue,
          pic: data[0]["picurl"].stringValue,
          score: member[indexPath.item]["score"].intValue
        )
        cell.delegate = self
        cell.topMemberData = memberData
      }
    }

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenSize = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    switch(screenSize){
    case 414:
      return CGSize(width:  294, height: 43)
    case 375:
      return screenHeight == 812 ? CGSize(width: 255, height: 50) : CGSize(width: 255, height: 37)
    case 320:
      return CGSize(width: 200, height: 35)
    default:
      return CGSize(width: 250, height: 40)
    }
  }
  
}

