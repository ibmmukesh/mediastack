//
//  UITableView+.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import Foundation
import UIKit

extension UITableView {
  
  func register<T: ViewReusable>(view: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: ViewReusable>(headerFooterView: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
  }
}
