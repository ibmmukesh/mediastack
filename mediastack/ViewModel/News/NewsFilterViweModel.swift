//
//  NewsFilterViweModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation

protocol NewsFilterViewModelProtocol{
    var newsFilterModels:[NewsFilterModel]? {get set}

    //Collection View Data
    func detailsForCell(indexPath:IndexPath)-> String?
    func headerTitle(indexPath:IndexPath)-> String?
    func defaultFilterModel() -> [NewsFilterModel]?
}

class NewsFilterViewModel: NewsFilterViewModelProtocol{
   
    init(){
        newsFilterModels = defaultFilterModel()
    }
        
    func defaultFilterModel() -> [NewsFilterModel]? {
        return [
            NewsFilterModel(name: "Category", filters: [SubFilter(name: "business", selected: false),SubFilter(name: "sports", selected: false)]),
            NewsFilterModel(name: "Country", filters: [SubFilter(name: "us", selected: false),SubFilter(name: "au", selected: false)]),
            NewsFilterModel(name: "Language", filters: [SubFilter(name: "en", selected: false),SubFilter(name: "ar", selected: false)])
        ]
    }
    
    var newsFilterModels: [NewsFilterModel]? = nil
}


//MARK: - Extension to return CollectionView business logic
extension NewsFilterViewModel{
    
    internal func detailsForCell(indexPath: IndexPath)-> String? {
        return self.newsFilterModels?[indexPath.section].filters[indexPath.item].name
    }
    
    internal func headerTitle(indexPath: IndexPath)-> String? {
        return self.newsFilterModels?[indexPath.section].name
    }
}
