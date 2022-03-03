//
//  NewsViewModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import Foundation

//MARK: NewsViewModelProtocol to manage I/O Binding.
protocol NewsViewModelProtocol{
    
    //Input, Output
    var newsList:[News]? {get}
    var pagination : Pagination? { get set}
    var paginationDidChange: ((NewsViewModelProtocol) -> ())? { get set } // function to call when instance did change

    //Initializer
    init(newsWebService:NewsWebservices?)
    
    //Function to fetch news
    func liveNews(sources:String, categories:String,countries:String,languages:String,keywords:String,sort:String,offset:Int,limit:Int,  completion:@escaping emptyCompletionHandler)
    
    //TableView Data
    func numberOfSection()->Int
    func numberOfRows()->Int
    func detailsForCell(indexPath:IndexPath)->News?
}

//MARK: NewsViewModel to handle business logic

class NewsViewModel: NewsViewModelProtocol{
    
    //Instance
    private var newsWebService: NewsWebservices?
    
    //Initialiser
    required init(newsWebService: NewsWebservices?) {
        self.newsWebService = newsWebService
    }
    
    internal var newsList: [News]? {
        return newsItems
    }
    
    internal var pagination: Pagination?{
        didSet{
            self.paginationDidChange?(self)
        }
    }
    
    var paginationDidChange: ((NewsViewModelProtocol) -> ())?
    private var newsItems = [News]()
    
    //Function to call live news webservice
    func liveNews(sources: String, categories: String, countries: String, languages: String, keywords: String, sort: String, offset: Int, limit: Int, completion: @escaping emptyCompletionHandler) {
        
        let parameter = NewsParameter(access_key: AppConstant.apiAccessKey, sources: sources, categories: categories, countries: countries, languages: languages, keywords: keywords, sort: sort, offset: offset, limit: limit)
        
        self.newsWebService?.liveNews(parameter: parameter, completionHandler: { (response) in

            switch response {
            case .success(value: let response) :
                if let newsFeed = response.data, newsFeed.count > 0 {
                    self.newsItems += newsFeed
                }
                if let pagination = response.pagination {
                    self.pagination = pagination
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            completion()
        })
    }
}

//MARK: Extension to return TableView News business logic
extension NewsViewModel{
    
    internal  func numberOfSection()->Int {
        return 1
    }
    
    internal func numberOfRows()->Int {
        return newsItems.count 
    }
    
    internal func detailsForCell(indexPath: IndexPath)->News? {
        return newsItems[indexPath.row] as News?
    }
}
