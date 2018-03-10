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
  
  private let image: UIImageView = {
    let image = UIImageView()
    image.image = #imageLiteral(resourceName: "Kaew")
    image.contentMode = UIViewContentMode.scaleAspectFit
    image.layer.cornerRadius = 5
    image.clipsToBounds = true
    image.sizeToFit()

    return image
  }()
  
  private let name: UILabel = {
    let label = UILabel()
    label.text = "แก้ว (Kaew)"
    label.font = UIFont(name: "Sukhumvit Set", size: 12)
    label.textAlignment = .center
    label.textColor = UIColor.grayText
    label.sizeToFit()
    
    return label
  }()
  
  private lazy var roundedView: UIView = {
    let roundedView = UIView()
    roundedView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.19).cgColor
    roundedView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.width), cornerRadius: 3).cgPath
    roundedView.layer.shadowOffset = CGSize(width: 0, height: 1)
    roundedView.layer.shadowOpacity = 4
    roundedView.layer.shadowRadius = 3
    
    return roundedView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    roundedView.addSubview(image)
    image.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)

    addSubview(roundedView)
    
    addSubview(name)
    name.frame = CGRect(x: 0, y: frame.width + 15, width: frame.width, height: 10)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
