//
//  MVVideoViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVVideoVC: UIViewController {
  
  // MARK: - Variables
  var mvLink: String? {
    didSet {
      webView.mvLink = mvLink
    }
  }
  
  private let screen = UIScreen.main.bounds
  private let webView = MVVideoView()

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(webView)
    webView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
  }
}
