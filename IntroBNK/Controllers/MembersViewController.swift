//
//  MembersViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MembersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellMemberView = "CellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.register(MemberCell.self, forCellWithReuseIdentifier: cellMemberView)
    collectionView?.backgroundColor = .white
    navigationItem.title = "Members"
  }
  
}

extension MembersViewController {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 18, left: 16, bottom: 18, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width/3) - 20, height: (view.frame.width/3) - 6)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMemberView, for: indexPath) as? MemberCell else { return UICollectionViewCell() }
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
}
