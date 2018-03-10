//
//  MVView.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 10/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVView: UIView {
  
  private let webView: UIWebView = {
    let web = UIWebView()
    
    if let url = URL(string: "https://www.youtube.com/watch?v=awJd6vaaZlc") {
      web.loadRequest(URLRequest(url: url))
    }
    
    web.translatesAutoresizingMaskIntoConstraints = false
    
    return web
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(webView)
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      webView.topAnchor.constraint(equalTo: self.topAnchor),
      webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
