//
//  NewsCell.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 9/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
  
  //MARK: - Variables
  var fetchPictureDelegate: FetchImageDelegate?
  
  var news: News? {
    didSet {
      guard let news = news else { return }
      
      fetchPictureDelegate?.fetchImageData(linkImageString: news.pic, completion: { (imageData) in
        DispatchQueue.main.async {
          self.pictureFrame.image = UIImage(data: imageData)
          self.loading.stopAnimating()
        }
      })
      
      let dateFormat = DateFormatter()
      dateFormat.dateFormat = "dd MMMM yyyy"
      let date = dateFormat.string(from: news.date)
      
      let timeFormat = DateFormatter()
      timeFormat.dateFormat = "HH.mm"
      let time = "เวลา \(timeFormat.string(from: news.date)) น."
      
      detail.text = "\(news.title)\n\(date)\n\(time)\n\(news.place)"
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
  
  private let wrapper: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 5
    view.backgroundColor = . white
    view.clipsToBounds = true
    
    return view
  }()
  
  private let pictureFrame: UIImageView = {
    let image = UIImageView()
    image.backgroundColor = UIColor.coverGray
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    
    return image
  }()
  
  private let detail: UILabel = {
    let text = UILabel()
    text.numberOfLines = 5
    text.font = UIFont(name: "Sukhumvit Set", size: 14)
    text.textColor = UIColor.grayText
    text.adjustsFontSizeToFitWidth = true
    text.minimumScaleFactor = 0.2
        
    return text
    
  }()
  
  private lazy var roundedView: UIView = {
    let roundedView = UIView()
    roundedView.translatesAutoresizingMaskIntoConstraints = false
    roundedView.layer.shadowColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 0.5).cgColor
    roundedView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: 5).cgPath
    roundedView.layer.shadowOffset = CGSize(width: 0, height: 2)
    roundedView.layer.shadowOpacity = 1
    roundedView.layer.shadowRadius = 2
    
    return roundedView
  }()
  
  //MARK: - Init View
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    pictureFrame.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerYAnchor.constraint(equalTo: pictureFrame.centerYAnchor),
      loading.centerXAnchor.constraint(equalTo: pictureFrame.centerXAnchor),
      loading.widthAnchor.constraint(equalToConstant: 50),
      loading.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    roundedView.addSubview(wrapper)
    
    wrapper.addSubview(pictureFrame)
    pictureFrame.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
    
    wrapper.addSubview(detail)
    detail.frame = CGRect(x: 15, y: self.frame.width + 5, width: self.frame.width - 30, height: 100)
    
    addSubview(roundedView)
    NSLayoutConstraint.activate([
      roundedView.topAnchor.constraint(equalTo: self.topAnchor),
      roundedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      roundedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      roundedView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
    NSLayoutConstraint.activate([
      wrapper.topAnchor.constraint(equalTo: self.topAnchor),
      wrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      wrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      wrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
