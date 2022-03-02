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
    var newsList : [News]? { get set}
    var newsListDidChange: ((NewsViewModelProtocol) -> ())? { get set } // function to call when instance did change

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
    
    var newsList: [News]?{
        didSet{
            self.newsListDidChange?(self)
        }
    }
    var newsListDidChange: ((NewsViewModelProtocol) -> ())?

    //Function to call live news webservice
    func liveNews(sources: String, categories: String, countries: String, languages: String, keywords: String, sort: String, offset: Int, limit: Int, completion: @escaping emptyCompletionHandler) {
        
        let parameter = NewsParameter(access_key: AppConstant.apiAccessKey, sources: sources, categories: categories, countries: countries, languages: languages, keywords: keywords, sort: sort, offset: 0, limit: 100)
        
        self.newsWebService?.liveNews(parameter: parameter, completionHandler: { (response) in

            switch response {
            case .success(value: let response) :
                print(response)
                if let newsFeed = response.data, newsFeed.count > 0 {
                    self.newsList = newsFeed
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
        return newsList?.count ?? 0
    }
    
    internal func detailsForCell(indexPath: IndexPath)->News? {
        return newsList?[indexPath.row] as News?
    }
}
