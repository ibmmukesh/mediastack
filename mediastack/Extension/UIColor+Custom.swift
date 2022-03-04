//
//  UIColor+Custom.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation
import UIKit

extension UIColor {
    
    class var mainBackground: UIColor {
        return UIColor(red: 252.0 / 255.0, green: 252.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
    
    class var textBlack: UIColor {
        return UIColor.black
    }
    
    class var textWhite: UIColor {
        return UIColor.white
    }
    
    class var transparent: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 199.0 / 255.0, alpha: 0.4)
    }
    
    class var coolBlue: UIColor {
        return UIColor(red: 46 / 255.0, green: 155 / 255.0, blue: 264 / 255.0, alpha: 1.0)
    }
    
    class var coolWhite: UIColor {
        return UIColor(red: 244 / 255.0, green: 242 / 255.0, blue: 246 / 255.0, alpha: 1.0)
    }
}

