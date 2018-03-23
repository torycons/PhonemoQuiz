//
//  UIView.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 18/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIView {
  func addShadowForRoundedButton(view: UIView, wrapper: UIView, cornerRadius: CGFloat) {
    let roundedView = UIView()
    let roundedRect = CGRect(x: wrapper.frame.origin.x, y: wrapper.frame.origin.y, width: wrapper.frame.width, height: wrapper.frame.height)
    roundedView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.17).cgColor
    roundedView.layer.shadowPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius).cgPath
    roundedView.layer.shadowOffset = CGSize(width: 0, height: 2)
    roundedView.layer.shadowOpacity = 1
    roundedView.layer.shadowRadius = 4
    
    view.addSubview(roundedView)
    view.bringSubview(toFront: wrapper)
  }
  
  func showLoading() {
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show()
  }
  
  func hideLoading() {
    SVProgressHUD.dismiss()
  }
  
  func buttonAnimateSpring(animation: @escaping () -> Void, completion: ((Bool) -> Void)?) {
    UIView.animate(
      withDuration: 0.76,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 1,
      options: .curveEaseOut,
      animations: animation,
      completion: completion
    )
  }
  
  func setupStatusBar(view: UIView) {
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    statusBarView.backgroundColor = UIColor.orangePhonemo
    view.addSubview(statusBarView)
  }
}
