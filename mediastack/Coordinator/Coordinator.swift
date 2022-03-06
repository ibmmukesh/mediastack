//
//  Coordinator.swift
//  mediastack
//
//  Created by Mukesh Lokare on 06/03/22.
//

import Foundation
import UIKit

typealias onFilterAppy = ((_ category:[String], _ country:[String], _ language:[String]) -> Void)

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func showNews()
    func showNewsDetail(news:News)
    func showNewsFilter(completion: @escaping onFilterAppy)

}

