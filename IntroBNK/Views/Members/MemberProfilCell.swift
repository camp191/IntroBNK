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
  
  private let pictureMember: UIImageView = {
    let profileImage = UIImageView()
    profileImage.image = #imageLiteral(resourceName: "KaewH")
    profileImage.contentMode = .scaleAspectFit
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    profileImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2.3).isActive = true
    
    return profileImage
  }()
  
  private let detailMember: UILabel = {
    var name = "ณัฐรุจา ชุติวรรณโสภณ\nNatruja Chutiwansopon\n\n"
    var date = "31 Mar 1994\n"
    var height = "156 cm\n"
    var province = "Chonburi\n"
    var like = "เครื่องสำอาง,น้ำหอม\n"
    var bloodGroup = "B\n"
    var hobby = "เล่นเปียโน, นอน, เดินเล่น"
    
    let boldText = [NSAttributedStringKey.font: UIFont(name: "SukhumvitSet-SemiBold", size: 14)!]
    let normalText = [NSAttributedStringKey.font: UIFont(name: "Sukhumvit Set", size: 14)!]
    
    let nameString = NSMutableAttributedString(string: name, attributes: boldText)
    let dateString = NSMutableAttributedString(string: "Date of birth: ", attributes: boldText)
    let heightString = NSMutableAttributedString(string: "Height: ", attributes: boldText)
    let provinceString = NSMutableAttributedString(string: "Province: ", attributes: boldText)
    let likeString = NSMutableAttributedString(string: "Like: ", attributes: boldText)
    let bloodGroupString = NSMutableAttributedString(string: "Blood Group: ", attributes: boldText)
    let hobbyString = NSMutableAttributedString(string: "Hobby: ", attributes: boldText)
    
    let dateDetail = NSMutableAttributedString(string: date, attributes: normalText)
    let heightDetail = NSMutableAttributedString(string: height, attributes: normalText)
    let provinceDetail = NSMutableAttributedString(string: province, attributes: normalText)
    let likeDetail = NSMutableAttributedString(string: like, attributes: normalText)
    let bloodGroupDetail = NSMutableAttributedString(string: bloodGroup, attributes: normalText)
    let hobbyDetail = NSMutableAttributedString(string: hobby, attributes: normalText)
    
    nameString.append(dateString)
    nameString.append(dateDetail)
    nameString.append(heightString)
    nameString.append(heightDetail)
    nameString.append(provinceString)
    nameString.append(provinceDetail)
    nameString.append(likeString)
    nameString.append(likeDetail)
    nameString.append(bloodGroupString)
    nameString.append(bloodGroupDetail)
    nameString.append(hobbyString)
    nameString.append(hobbyDetail)
    
    let detail = UILabel()
    detail.attributedText = nameString
    detail.textColor = UIColor.grayText
    detail.numberOfLines = 9
    detail.adjustsFontSizeToFitWidth = true
    detail.minimumScaleFactor = 0.2
    
    return detail
  }()
  
  private lazy var detailStack: UIStackView = {
    let detailStack = UIStackView(arrangedSubviews: [pictureMember, detailMember])
    detailStack.axis = .horizontal
    detailStack.spacing = 20
    detailStack.translatesAutoresizingMaskIntoConstraints = false
    
    return detailStack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(header)
    NSLayoutConstraint.activate([
      header.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      header.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
      ])
    
    addSubview(detailStack)
    NSLayoutConstraint.activate([
      detailStack.topAnchor.constraint(equalTo: header.bottomAnchor),
      detailStack.leftAnchor.constraint(equalTo: self.leftAnchor),
      detailStack.rightAnchor.constraint(equalTo: self.rightAnchor),
      detailStack.heightAnchor.constraint(equalToConstant: 270)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
