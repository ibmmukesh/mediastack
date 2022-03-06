//
//  ViewReusable.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//
///ViewReusable file to return the nibNames & reuse identifier based on filename.
///

import Foundation
import UIKit

protocol ViewReusable {
  static var nibName: String { get }
  static var reuseIdentifier: String { get }
}

extension ViewReusable where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
