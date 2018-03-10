//
//  MemberProfilCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 10/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberProfileCell: UICollectionViewCell {
  
  private let header: UILabel = {
    let text = UILabel()
    text.text = "แก้ว (Kaew)"
    text.font = UIFont(name: "SukhumvitSet-SemiBold", size: 24)
    text.sizeToFit()
    text.textColor = UIColor.grayText
    text.translatesAutoresizingMaskIntoConstraints = false
    
    return text
  }()
  
  private let detailMember: UIStackView = {
    let profileImage = UIImageView()
    profileImage.image = #imageLiteral(resourceName: "KaewH")
    profileImage.contentMode = .scaleAspectFit
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    profileImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2.3).isActive = true
    
    
    let detail = UILabel()
    detail.textColor = UIColor.grayText
    detail.font = UIFont(name: "SukhumvitSet-SemiBold", size: 14)
    detail.text = "ณัฐรุจา ชุติวรรณโสภณ\nNatruja Chutiwansopon\n\nDate of birth: 31 Mar 1994\nHeight: 156 cm\nProvince: Chonburi\nLike: เครื่องสำอาง,น้ำหอม\nBlood Group: B\nHobby: เล่นเปียโน, นอน, เดินเล่น"
    detail.numberOfLines = 9
    detail.adjustsFontSizeToFitWidth = true
    detail.minimumScaleFactor = 0.2
    
    let stack = UIStackView(arrangedSubviews: [profileImage, detail])
    stack.axis = .horizontal
    stack.spacing = 20
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    return stack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(header)
    NSLayoutConstraint.activate([
      header.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      header.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
      ])
    
    addSubview(detailMember)
    NSLayoutConstraint.activate([
      detailMember.topAnchor.constraint(equalTo: header.bottomAnchor),
      detailMember.leftAnchor.constraint(equalTo: self.leftAnchor),
      detailMember.rightAnchor.constraint(equalTo: self.rightAnchor),
      detailMember.heightAnchor.constraint(equalToConstant: 270)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
