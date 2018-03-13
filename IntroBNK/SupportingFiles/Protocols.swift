//
//  Protocols.swift
//  IntroBNK
//
//  Created by Thanapat Sorralump on 12/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

protocol PushNavigationDelegate {
  func pushViewController(viewController: UIViewController, animate: Bool)
}

protocol FetchImageDelegate {
  func fetchImageData(linkImageString: String, completion: @escaping (Data) -> Void) -> Void
}

extension FetchImageDelegate {
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
}
