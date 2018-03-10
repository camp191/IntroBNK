//
//  MemberViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var titleName: String?
  
  private let profileCellName = "ProfileCell"
  private let otherCellName = "OtherCell"
  private let headerOther = "HeaderOther"
  
  private let screen = UIScreen.main.bounds
  
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
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: profileCellName)
    collectionView?.register(OtherMemberCell.self, forCellWithReuseIdentifier: otherCellName)
  }
}

extension MemberVC {
  
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
    
    let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellName, for: indexPath)
    guard let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: otherCellName, for: indexPath) as? OtherMemberCell else { return UICollectionViewCell() }
    
    profileCell.backgroundColor = .red
    
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
      size = CGSize(width: screen.width, height: 266)
    } else if indexPath.section == 1 {
      size = CGSize(width: screen.width, height: 165)
    }
    return size
  }
  
}











