//
//  ViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 2/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - Variables
  private let mainItems = [
    Main(mainImage: "News"),
    Main(mainImage: "Members"),
    Main(mainImage: "MV")
  ]
  private let mainCellIdentifier = "CellID"
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpNavigation()
    setupConllectionView()
    
  }
  
  // MARK: - Setup UI Function
  private func setupConllectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(MainCell.self, forCellWithReuseIdentifier: mainCellIdentifier)
  }
  
  private func setUpNavigation() {
    navigationItem.title = "BNK48"
  }
  
  private func createAndPushCollectionViewPage(with viewController: UICollectionViewController, line spaceing: CGFloat) {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = spaceing
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension MainVC {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let layout = UICollectionViewFlowLayout()
    
    switch indexPath.row {
    case 0:
      createAndPushCollectionViewPage(with: NewsVC(collectionViewLayout: layout), line: 27)
    case 1:
      createAndPushCollectionViewPage(with: MembersVC(collectionViewLayout: layout), line: 27)
    case 2:
      createAndPushCollectionViewPage(with: MVVC(collectionViewLayout: layout), line: 24)
    default:
      let aleart = UIAlertController(title: "Error!!", message: "Please try again", preferredStyle: .alert)
      aleart.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(aleart, animated: true, completion: nil)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width-40, height: (view.frame.width-40)/2.105)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainItems.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellIdentifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
    
    let mainItem = mainItems[indexPath.item]
    cell.mainData = mainItem
    
    return cell
  }
  
}

