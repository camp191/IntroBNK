//
//  OtherMemberCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 10/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class OtherMemberCell: UICollectionViewCell, FetchImageDelegate {
  
  var members: [Member]?
  var delegate: PushNavigationDelegate?
  
  private let memberCell = "memberCell"
  
  internal func fetchImageData(linkImageString: String, completion: @escaping (Data) -> Void) {
    if let urlImage = URL(string: linkImageString) {
      let task = URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, res, err) in
        if let err = err {
          print("Failed to retrieve the image: ", err)
          return
        }
        guard let imageData = data else { return }
        completion(imageData)
      })
      task.resume()
    }
  }
  
  private let otherMembers: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsHorizontalScrollIndicator = false
    
    return collectionView
  }()
  
  private let header: UILabel = {
    let text = UILabel()
    text.text = "สมาชิกคนอื่นๆ"
    text.font = UIFont(name: "SukhumvitSet-SemiBold", size: 14)
    text.textColor = UIColor.grayText
    text.sizeToFit()
    text.translatesAutoresizingMaskIntoConstraints = false
    
    return text
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(header)
    NSLayoutConstraint.activate([
      header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      header.topAnchor.constraint(equalTo: self.topAnchor),
      ])
    
    otherMembers.delegate = self
    otherMembers.dataSource = self
    otherMembers.register(MemberCell.self, forCellWithReuseIdentifier: memberCell)
    addSubview(otherMembers)
    NSLayoutConstraint.activate([
      otherMembers.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      otherMembers.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      otherMembers.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5),
      otherMembers.widthAnchor.constraint(equalToConstant: self.frame.width),
      otherMembers.heightAnchor.constraint(equalToConstant: 150)
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OtherMemberCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let layout = UICollectionViewFlowLayout()
    let otherMemberViewController = MemberVC(collectionViewLayout: layout)
    otherMemberViewController.members = members
    otherMemberViewController.memberData = members?[indexPath.item]
    otherMemberViewController.titleName = members?[indexPath.item].nickname
    self.delegate?.pushViewController(viewController: otherMemberViewController, animate: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width/3) - 20, height: (UIScreen.main.bounds.width/3) + 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let members = members else { return 0 }
    return members.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: memberCell, for: indexPath) as? MemberCell else { return UICollectionViewCell() }
    cell.delegate = self
    cell.member = members?[indexPath.item]
    
    return cell
  }
}
