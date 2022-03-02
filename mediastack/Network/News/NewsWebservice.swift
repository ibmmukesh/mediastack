//
//  NewsWebservice.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///NewsWebservices file to consolidate all the api functions that needs to call over network manager class by enjecting NewsAPI information this again depend on each type of module.
///

import Foundation

protocol NewsWebservicesProtocol {
    func liveNews(parameter: NewsParameter, completionHandler: @escaping(ApiResponse<ApiResponseModel<[News]>>)->())
}
 
struct NewsWebservices: NewsWebservicesProtocol {

    private let service: NetworkManager<NewsAPI>
    
    init(service: NetworkManager<NewsAPI> = NetworkManager<NewsAPI>()) {
        self.service = service
    }
        
    internal func liveNews(parameter: NewsParameter, completionHandler: @escaping (ApiResponse<ApiResponseModel<[News]>>) -> ()) {
        service.requestObject(path: .liveNews(parameters: parameter.toJSON(param: parameter)), completionHandler: completionHandler)
    }
}

