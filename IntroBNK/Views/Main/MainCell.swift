//
//  MainCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
  
  var mainData: Main? {
    didSet {
      guard let mainData = mainData else { return }
      mainImage.image = UIImage(named: mainData.mainImage)
    }
  }
  
  //MARK: - Animation State
  override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        UIView.animate(
          withDuration: 0.3,
          delay: 0, options: .curveEaseOut,
          animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: nil
        )
      } else {
        UIView.animate(
          withDuration: 0.3,
          delay: 0, options: .curveEaseOut,
          animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil
        )
      }
    }
  }
  
  //MARK: - UI Component
  private let mainImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = UIViewContentMode.scaleAspectFit
    image.layer.shadowOpacity = 0.25
    image.layer.shadowColor = UIColor.black.cgColor
    image.layer.shadowOffset = CGSize(width: 3, height: 3)
    image.layer.masksToBounds = false
    
    return image
  }()
  
  //MARK: - Init View
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(mainImage)
    mainImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
