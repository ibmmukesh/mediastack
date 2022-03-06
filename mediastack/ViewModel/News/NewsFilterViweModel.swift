//
//  NewsFilterViweModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation

protocol NewsFilterViewModelProtocol{
    var newsFilterModels:[NewsFilterModel]? {get}
    
    //Collection View Data
    func detailsForCell(indexPath:IndexPath)-> String?
    func headerTitle(indexPath:IndexPath)-> String?
}

class NewsFilterViewModel: NewsFilterViewModelProtocol{
   
    init(){
        
    }
    
    internal var newsFilterModels: [NewsFilterModel]? {
        let filterModels = [
            NewsFilterModel(name: "Category", filters: ["business","sports"]),
            NewsFilterModel(name: "Country", filters: ["us", "au"]),
            NewsFilterModel(name: "Language", filters: ["en","ar"])
        ]
        return filterModels
    }
}


//MARK: - Extension to return CollectionView business logic
extension NewsFilterViewModel{
    
    internal func detailsForCell(indexPath: IndexPath)-> String? {
        return self.newsFilterModels?[indexPath.section].filters[indexPath.item]
    }
    
    internal func headerTitle(indexPath: IndexPath)-> String? {
        return self.newsFilterModels?[indexPath.section].name
    }
}
