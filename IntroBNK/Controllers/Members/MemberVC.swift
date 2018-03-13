//
//  MemberViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, PushNavigationDelegate, FetchImageDelegate {

  var members: [Member]?
  var memberData: Member? {
    didSet {
      titleName = memberData?.nickname
    }
  }
  var titleName: String?
  
  private let profileCellName = "ProfileCell"
  private let otherCellName = "OtherCell"
  private let headerOther = "HeaderOther"
  
  private let screen = UIScreen.main.bounds
  
  func fetchImageData(linkImageString: String, completion: @escaping (Data) -> Void) {
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
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigation()
    setupCollectionView()
    
  }
  
  func setupNavigation() {
    navigationItem.title = titleName
  }
  
  func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(MemberProfileCell.self, forCellWithReuseIdentifier: profileCellName)
    collectionView?.register(OtherMemberCell.self, forCellWithReuseIdentifier: otherCellName)
  }
  
  func pushViewController(viewController: UIViewController, animate: Bool) {
    navigationController?.pushViewController(viewController, animated: animate)
  }
}

extension MemberVC {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    var edge = UIEdgeInsets()
    
    if section == 0 {
      edge = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    } else {
      edge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    return edge
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    var itemsInSection = Int()
    if section == 0 {
      itemsInSection = 1
    } else if section == 1 {
      itemsInSection = 1
    }
    
    return itemsInSection
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var cell = UICollectionViewCell()
    
    guard let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellName, for: indexPath) as? MemberProfileCell else { return UICollectionViewCell() }
    guard let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: otherCellName, for: indexPath) as? OtherMemberCell else { return UICollectionViewCell() }
    
    otherCell.delegate = self
    profileCell.delegate = self
    
    otherCell.members = members
    profileCell.memberData = memberData
    
    if indexPath.section == 0 {
      cell = profileCell
    } else if indexPath.section == 1 {
      cell = otherCell
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var size = CGSize()
    
    if indexPath.section == 0 {
      size = CGSize(width: screen.width - 30, height: 320)
    } else if indexPath.section == 1 {
      size = CGSize(width: screen.width, height: 165)
    }
    return size
  }
  
}

