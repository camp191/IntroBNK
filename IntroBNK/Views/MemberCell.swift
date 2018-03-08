//
//  MemberCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 7/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberCell: UICollectionViewCell {
  
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
  
  let image: UIImageView = {
    let image = UIImageView()
    image.image = #imageLiteral(resourceName: "Kaew")
    image.contentMode = UIViewContentMode.scaleAspectFit
    image.layer.cornerRadius = 5
    image.clipsToBounds = true

    return image
  }()
  
  let name: UILabel = {
    let label = UILabel()
    label.text = "แก้ว (Kaew)"
    label.font = UIFont(name: "Sukhumvit Set", size: 12)
    label.textAlignment = .center
    label.textColor = UIColor.grayText
    label.sizeToFit()
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(image)
    image.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
    
    addSubview(name)
    name.frame = CGRect(x: 0, y: frame.width + 15, width: frame.width, height: 10)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
