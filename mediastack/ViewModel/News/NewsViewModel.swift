//
//  NewsViewModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import Foundation

//MARK: - NewsViewModelProtocol to manage I/O Binding.
protocol NewsViewModelProtocol{
    
    //Input, Output
    var newsList:[News]? {get}
    var pagination : Pagination? { get set}
    var paginationDidChange: ((NewsViewModelProtocol) -> ())? { get set } // function to call when instance did change
    var error:ApiError? {get}

    //Initializer
    init(newsWebService:NewsWebservices?)
    
    //Function to fetch news
    func liveNews(parameter:NewsParameter,  completion:@escaping completionHandler)
    
    //TableView Data
    func detailsForCell(indexPath:IndexPath)->News?
}

//MARK: - NewsViewModel to handle business logic

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
    internal var error: ApiError? {
        return apiError
    }
    
    
    var paginationDidChange: ((NewsViewModelProtocol) -> ())?
    private var newsItems = [News]()
    private var apiError : ApiError?
    //Function to call live news webservice
    func liveNews(parameter:NewsParameter, completion: @escaping completionHandler) {
                
        self.newsWebService?.liveNews(parameter: parameter, completionHandler: { (response) in

            switch response {
            case .success(value: let response) :
                if let error = response.error{
                    // If any error occurre in response as per API architectecture kind of data not available, subscription excceed.
                    self.apiError = error
                }else{
                    //Success
                    if let newsFeed = response.data, newsFeed.count > 0 {
                        self.newsItems += newsFeed
                    }
                    if let pagination = response.pagination {
                        self.pagination = pagination
                    }
                }
            case .failure(let error):
                print(error.message)
                break
            }
            completion()
        })
    }
}

//MARK: - Extension to return TableView News business logic
extension NewsViewModel{
    
    internal func detailsForCell(indexPath: IndexPath)->News? {
        return newsItems[indexPath.row] as News?
    }
}
