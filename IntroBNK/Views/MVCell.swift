//
//  MVCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVCell: UICollectionViewCell {
  
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
  
  let cover: UIImageView = {
    let image = UIImageView()
    image.image = #imageLiteral(resourceName: "MVCover")
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 5
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  let mvDetail: UIStackView = {
    let name = UILabel()
    name.text = "Anata to Christmas Eve\nคำสัญญาแห่งคริสต์มาสอีฟ"
    name.numberOfLines = 2
    name.font = UIFont(name: "SukhumvitSet-SemiBold", size: 14)
    name.textColor = UIColor.grayText
    name.adjustsFontSizeToFitWidth = true
    name.minimumScaleFactor = 0.2
    
    let date = UILabel()
    date.text = "26 กุมภาพันธ์ 2018"
    date.font = UIFont(name: "Sukhumvit Set", size: 10)
    date.textColor = UIColor.grayText
    date.adjustsFontSizeToFitWidth = true
    date.minimumScaleFactor = 0.2
    
    let stack = UIStackView(arrangedSubviews: [name, date])
    stack.axis = .vertical
    stack.distribution = .equalCentering
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    return stack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(cover)
    NSLayoutConstraint.activate([
      cover.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      cover.topAnchor.constraint(equalTo: self.topAnchor),
      cover.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      cover.widthAnchor.constraint(equalToConstant: self.frame.height * 1.78)
      ])
    
    addSubview(mvDetail)
    NSLayoutConstraint.activate([
      mvDetail.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 10),
      mvDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      mvDetail.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      mvDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

