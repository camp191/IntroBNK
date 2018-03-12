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
