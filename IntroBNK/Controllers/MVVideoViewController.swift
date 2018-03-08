//
//  MVVideoViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVVideoViewController: UIViewController {
  
  private let screen = UIScreen.main.bounds
  
  let webView: UIWebView = {
    let web = UIWebView()
    
    if let url = URL(string: "https://www.youtube.com/watch?v=awJd6vaaZlc") {
      web.loadRequest(URLRequest(url: url))
    }
    
    return web
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(webView)
    webView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
  }
}
