//
//  GlobalFunction.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation
import UIKit

class GlobalFunction{
    
    static func topViewController() -> UIViewController? {
        var controller: UIViewController?
        
        if #available(iOS 13, *) {
            controller = UIApplication.shared.keyWindowPresentedController
        }else{
            controller = UIApplication.shared.windows.first?.rootViewController
        }
        
        if let navigationController = controller as? UINavigationController {
            return navigationController.visibleViewController
        }
        if let tabController = controller as? UITabBarController {
            if tabController.selectedViewController != nil {
                return topViewController()
            }
        }
        if let presented = controller?.presentedViewController {
            return presented
        }
        if let alert = controller as? UIAlertController {
            if let navigationController = alert.presentingViewController as? UINavigationController {
                return navigationController.viewControllers.last
            }
            return alert.presentingViewController
        }
        return controller
    }

    static func showEmptyView(_ emptyType: EmptyViewType? = .serverError, _ error: ApiError? = nil){
        
        DispatchQueue.main.async {
            let topVC = GlobalFunction.topViewController()
            let emptyView:EmptyView = EmptyView()
            emptyView.delegate = topVC as? EmptyViewDelegate
            if let topVCView = topVC?.view{
                emptyView.frame = topVCView.bounds
                emptyView.emptyType = emptyType ?? .serverError //Pass empty type enum case to manage specific type of empty data
                if let apiError = error{
                    emptyView.setUpEmptyView(apiError)
                }else{
                    emptyView.setUpEmptyView()
                }
                topVCView.addSubview(emptyView)
            }
        }
    }
}
