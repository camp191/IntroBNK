//
//  MVView.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 10/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVVideoView: UIView {
  
  var mvLink: String? {
    didSet {
      guard let mvLink = mvLink else { return }
      guard let url = URL(string: mvLink) else { return }
      self.webView.loadRequest(URLRequest(url: url))
    }
  }
  
  private let webView: UIWebView = {
    let web = UIWebView()
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
