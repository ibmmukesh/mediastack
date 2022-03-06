//
//  AppDelegate+.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation
import UIKit

extension UIApplication {

    var keyWindow: UIWindow? {
        // Get connected scenes
        let connectedScenes = UIApplication.shared.connectedScenes
                    .filter({
                        $0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                
        let window = connectedScenes.first?
                    .windows
                    .first { $0.isKeyWindow }

        return window
    }
    
    var keyWindowPresentedController: UIViewController? {
        var viewController = self.keyWindow?.rootViewController
        
        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }
        
        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }
        
        return viewController
    }
    
}
