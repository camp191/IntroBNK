//
//  MemberViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MemberViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var titleName: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = titleName
    collectionView?.backgroundColor = .white
  }
}
