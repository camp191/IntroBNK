//
//  MemberDetailCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberDetailCell: UICollectionViewCell {
  
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
    image.contentMode = .scaleAspectFit
    image.layer.cornerRadius = 5
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  let mvDetail: UITextView = {
    let text = UITextView()
    
    let attributeText = NSMutableAttributedString(
      string: "Anata to Christmas Eve\nคำสัญญาแห่งคริสต์มาสอีฟ",
      attributes: [
        NSAttributedStringKey.font: UIFont(name: "Sukhumvit Set", size: 14)!,
        NSAttributedStringKey.foregroundColor: UIColor.grayText
      ]
    )
    
    attributeText.append(NSAttributedString(
      string: "\n\n26 กุมภาพันธ์ 2018",
      attributes: [
        NSAttributedStringKey.font: UIFont(name: "Sukhumvit Set", size: 12)!,
        NSAttributedStringKey.foregroundColor: UIColor.grayText
      ])
    )
    
    text.attributedText = attributeText
    text.textAlignment = .left
    text.isEditable = false
    text.isSelectable = false
    text.isScrollEnabled = false
    text.translatesAutoresizingMaskIntoConstraints = false
    
    return text
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(cover)
    NSLayoutConstraint.activate([
      cover.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      cover.topAnchor.constraint(equalTo: self.topAnchor),
      cover.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      cover.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
      ])
    
    addSubview(mvDetail)
    NSLayoutConstraint.activate([
      mvDetail.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 10),
      mvDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      mvDetail.topAnchor.constraint(equalTo: self.topAnchor),
      mvDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}







