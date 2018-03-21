//
//  MembersViewController.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 6/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MembersVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FetchImageDelegate {

  //MARK: - Variables
  private let cellMemberView = "CellID"
  private var members = [Member]()
  
  //MARK: - UI Component
  private let loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.activityIndicatorViewStyle = .gray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    
    return indicator
  }()
  
  //MARK: - Fetch Data
  private func fetchAllMembersData() {
    APIService.shared.getFireStoreData(from: "Members") { (queryDocuments) in
      for document in queryDocuments {
        let member = Member(document: document)
        self.members.append(member)
      }
      
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
        self.loading.stopAnimating()
      }
    }
  }
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLoadingIndicator()
    fetchAllMembersData()
    setupNavigation()
    setupCollectionView()
  }
  
  //MARK: - Setup UI Functions
  private func setupNavigation() {
    navigationItem.title = "Members"
  }
  
  private func setupCollectionView() {
    collectionView?.register(MemberCell.self, forCellWithReuseIdentifier: cellMemberView)
    collectionView?.backgroundColor = .white
  }
  
  private func setupLoadingIndicator() {
    collectionView?.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: (collectionView?.centerXAnchor)!),
      loading.centerYAnchor.constraint(equalTo: (collectionView?.centerYAnchor)!)
      ])
  }
  
}

extension MembersVC {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let layout = UICollectionViewFlowLayout()
    let memberViewController = MemberVC(collectionViewLayout: layout)
    memberViewController.memberData = members[indexPath.item]
    memberViewController.members = members
    navigationController?.pushViewController(memberViewController, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 18, left: 16, bottom: 18, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width/3) - 20, height: (view.frame.width/3) + 10)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMemberView, for: indexPath) as? MemberCell else { return UICollectionViewCell() }
    cell.delegate = self
    cell.member = members[indexPath.item]
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return members.count
  }
}
