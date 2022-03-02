//
//  UIView+.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import Foundation
import UIKit

extension UIView {
    
  func roundCorners() {
    clipsToBounds = true
    layer.cornerRadius = min(bounds.height, bounds.width) * 0.5
  }
  
  func curveAllCorners(withRadius radius: CGFloat) {
    clipsToBounds = true
    layer.cornerRadius = radius
  }
  
  func curveCorners(_ corners: UIRectCorner, radius: CGFloat) {
    clipsToBounds = true
    let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = bounds
    maskLayer.path = maskPath.cgPath
    maskLayer.masksToBounds = true
    layer.mask = maskLayer
  }
}
