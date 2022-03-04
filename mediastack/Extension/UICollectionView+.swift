//
//  UICollectionView+.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation
import UIKit

extension UICollectionView {
  
  func register<T: ViewReusable>(view: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: ViewReusable>(view: T.Type, bundle: Bundle? = nil, supplementaryViewKind: String) {
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: supplementaryViewKind, withReuseIdentifier: T.reuseIdentifier)
  }
    
}
