//
//  MainCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
  
  let mainImage: UIImageView = {
    let image = UIImageView()
    image.layer.shadowOpacity = 0.25
    image.layer.shadowColor = UIColor.black.cgColor
    image.layer.shadowOffset = CGSize(width: 3, height: 3)
    image.layer.masksToBounds = false
    
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(mainImage)
    mainImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
