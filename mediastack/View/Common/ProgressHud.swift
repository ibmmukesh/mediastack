//
//  ProgressHud.swift
//  mediastack
//
//  Created by Mukesh Lokare on 06/03/22.
//

import Foundation
import UIKit


class ProgressHud {
    
    static let sharedInstance = ProgressHud()
    
    var container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var subContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3.0, height: UIScreen.main.bounds.size.width / 4.0))
    var activityIndicatorView = UIActivityIndicatorView()
    
    init() {
        //Main Container
        container.backgroundColor = UIColor.clear
        
        //Sub Container
        subContainer.layer.cornerRadius = 5.0
        subContainer.layer.masksToBounds = true
        subContainer.backgroundColor = UIColor.clear
        
        //Activity Indicator
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func show(view: UIView) -> Void {
        
        container.frame = view.bounds
        container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.large
        } else {
            activityIndicatorView.style = UIActivityIndicatorView.Style.whiteLarge
        }
        activityIndicatorView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        activityIndicatorView.color = UIColor.white
        
        activityIndicatorView.startAnimating()
        container.addSubview(activityIndicatorView)
        view.addSubview(container)
        view.bringSubviewToFront(container)
        
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 0.0
        }) { finished in
            self.activityIndicatorView.stopAnimating()
            
            self.activityIndicatorView.removeFromSuperview()
            self.subContainer.removeFromSuperview()
            self.container.removeFromSuperview()
        }
    }
}
