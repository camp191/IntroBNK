//
//  MemberProfilCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 10/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberProfileCell: UICollectionViewCell {
  
  //MARK: - Variables
  var delegate: FetchImageDelegate?
  
  var memberData: Member? {
    didSet {
      guard let member = memberData else { return }
      header.text = member.nickname
      
      setupDetailStack(member: member)
      setupLoading()
      
      self.delegate?.fetchImageData(linkImageString: member.picBig, completion: { (imageData) in
        DispatchQueue.main.async {
          self.pictureMember.image = UIImage(data: imageData)
          self.loading.stopAnimating()
        }
      })
    }
  }
  
  //MARK: - UI Components
  private let loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.activityIndicatorViewStyle = .gray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    
    return indicator
  }()
  
  private let header: UILabel = {
    let text = UILabel()
    text.font = UIFont(name: "SukhumvitSet-SemiBold", size: 24)
    text.sizeToFit()
    text.textColor = UIColor.grayText
    text.translatesAutoresizingMaskIntoConstraints = false
    
    return text
  }()
  
  private let pictureMember: UIImageView = {
    let profileImage = UIImageView()
    profileImage.contentMode = .scaleAspectFit
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    profileImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2.3).isActive = true
    
    return profileImage
  }()
  
  private lazy var detailMember: UILabel = {
    let detail = UILabel()
    detail.textColor = UIColor.grayText
    detail.numberOfLines = 11
    
    return detail
  }()
  
  private lazy var detailStack: UIStackView = {
    let detailStack = UIStackView(arrangedSubviews: [pictureMember, detailMember])
    detailStack.axis = .horizontal
    detailStack.spacing = 20
    detailStack.translatesAutoresizingMaskIntoConstraints = false
    
    return detailStack
  }()
  
  //MARK: - Init View
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(header)
    NSLayoutConstraint.activate([
      header.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      header.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
      ])
  }
  
  //MARK: - Setup View Function
  func setupDetailStack(member: Member) {
    setupDetailLabel(member: member)
    
    addSubview(detailStack)
    NSLayoutConstraint.activate([
      detailStack.topAnchor.constraint(equalTo: header.bottomAnchor),
      detailStack.leftAnchor.constraint(equalTo: leftAnchor),
      detailStack.rightAnchor.constraint(equalTo: rightAnchor),
      detailStack.heightAnchor.constraint(equalToConstant: 270)
      ])
  }
  
  func setupLoading() {
    pictureMember.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: pictureMember.centerXAnchor),
      loading.centerYAnchor.constraint(equalTo: pictureMember.centerYAnchor)
      ])
  }
  
  func setupDetailLabel(member: Member) {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "dd MMM yyyy"
    let date = dateFormat.string(from: member.dateOfBirth)
    
    let boldText = [NSAttributedStringKey.font: UIFont(name: "SukhumvitSet-SemiBold", size: 14)!]
    let normalText = [NSAttributedStringKey.font: UIFont(name: "Sukhumvit Set", size: 14)!]
    
    let nameString = NSMutableAttributedString(string: "\(member.name)\n\(member.nameEng)\n\n", attributes: boldText)
    let dateString = NSMutableAttributedString(string: "Birthday: ", attributes: boldText)
    let heightString = NSMutableAttributedString(string: "Height: ", attributes: boldText)
    let provinceString = NSMutableAttributedString(string: "Province: ", attributes: boldText)
    let likeString = NSMutableAttributedString(string: "Like: ", attributes: boldText)
    let bloodGroupString = NSMutableAttributedString(string: "Blood Group: ", attributes: boldText)
    let hobbyString = NSMutableAttributedString(string: "Hobby: ", attributes: boldText)
    
    let dateDetail = NSMutableAttributedString(string: "\(date)\n", attributes: normalText)
    let heightDetail = NSMutableAttributedString(string: "\(member.height) ซม.\n", attributes: normalText)
    let provinceDetail = NSMutableAttributedString(string: "\(member.province)\n", attributes: normalText)
    let likeDetail = NSMutableAttributedString(string: "\(member.like)\n", attributes: normalText)
    let bloodGroupDetail = NSMutableAttributedString(string: "\(member.bloodGroup)\n", attributes: normalText)
    let hobbyDetail = NSMutableAttributedString(string: "\(member.hobby)", attributes: normalText)
    
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
    
    self.detailMember.attributedText = nameString
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
