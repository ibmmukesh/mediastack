//
//  Coordinator.swift
//  mediastack
//
//  Created by Mukesh Lokare on 05/03/22.
//

import Foundation
import UIKit

protocol RouterController {
    func getViewController<T: UIViewController>(_ viewControllerType: T.Type, _ name: String) -> T
}

extension RouterController {
    func getViewController<T>(_ viewControllerType: T.Type, _ name: String) -> T where T: UIViewController {
        let storyBoard = UIStoryboard.init(name: name, bundle: Bundle.main)
        let identifier = String(describing: T.self) // Let's say view controller's storyboard identifier is same as class name
        return storyBoard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
