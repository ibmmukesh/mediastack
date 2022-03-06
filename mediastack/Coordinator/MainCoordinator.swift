//
//  MainCoordinator.swift
//  mediastack
//
//  Created by Mukesh Lokare on 06/03/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showNews() {
        let vc = NewsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showNewsDetail(news:News){
        let vc = NewsDetailViewController.instantiate()
        vc.coordinator = self
        //Initialize ViewModel & pass required depdendencies.
        vc.newsDetailViewModel = NewsDetailViewModel(news: news)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNewsFilter(completion:@escaping onFilterAppy) {
        let vc = NewsFilterViewController.instantiate()
        vc.coordinator = self
        vc.newsFilterViewModel = NewsFilterViewModel()
        vc.onFilterAppy = {(category, country, language) in
            completion(category,country,language)
        }
        navigationController.present(vc, animated: true, completion: nil)
    }
}
