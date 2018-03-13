//
//  MVCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 8/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MVCell: UICollectionViewCell {
  
  //MARK: - Variables
  var fetchPictureDelegate: FetchImageDelegate?
  
  var musicVideo: MusicVideo? {
    didSet {
      guard let musicVideo = musicVideo else { return }
      
      fetchPictureDelegate?.fetchImageData(linkImageString: musicVideo.pic, completion: { (imageData) in
        DispatchQueue.main.async {
          self.cover.image = UIImage(data: imageData)
          self.loading.stopAnimating()
        }
      })
      
      name.text = "\(musicVideo.title)\n\(musicVideo.titleThai)"
      let dateFormat = DateFormatter()
      dateFormat.dateFormat = "dd MMMM yyyy"
      date.text = dateFormat.string(from: musicVideo.date)
      
    }
  }
  
  //MARK: - Animation State
  override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        UIView.animate(
          withDuration: 0.3,
          delay: 0, options: .curveEaseOut,
          animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: nil
        )
      } else {
        UIView.animate(
          withDuration: 0.3,
          delay: 0, options: .curveEaseOut,
          animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil
        )
      }
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
  
  private let cover: UIImageView = {
    let image = UIImageView()
    image.backgroundColor = UIColor.coverGray
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 5
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    
    return image
  }()
  
  private let name: UILabel = {
    let name = UILabel()
    name.numberOfLines = 2
    name.font = UIFont(name: "SukhumvitSet-Medium", size: 16)
    name.textColor = UIColor.grayText
    name.adjustsFontSizeToFitWidth = true
    name.minimumScaleFactor = 0.2
    
    return name
  }()
  
  private let date: UILabel = {
    let date = UILabel()
    date.font = UIFont(name: "SukhumvitSet-Light", size: 12)
    date.textColor = UIColor.grayText
    date.adjustsFontSizeToFitWidth = true
    date.minimumScaleFactor = 0.2
    
    return date
  }()
  
  private lazy var mvDetail: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [self.name, self.date])
    stack.axis = .vertical
    stack.distribution = .equalCentering
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    return stack
  }()
  
  //MARK: - Init View
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    cover.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
      loading.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
      loading.widthAnchor.constraint(equalToConstant: 50),
      loading.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    addSubview(cover)
    NSLayoutConstraint.activate([
      cover.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      cover.topAnchor.constraint(equalTo: self.topAnchor),
      cover.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      cover.widthAnchor.constraint(equalToConstant: self.frame.height * 1.78)
      ])
    
    addSubview(mvDetail)
    NSLayoutConstraint.activate([
      mvDetail.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 10),
      mvDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      mvDetail.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      mvDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

