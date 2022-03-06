//
//  NewsAPI.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///NewsAPI file to encapsulate API request info i.e EndURL, Param, Type, Headers & Task & this file depend on each type of Module that are present in the application.
///

import Foundation
import Alamofire

// MARK: - Provider support

enum NewsAPI {
    case liveNews(parameters: [String: Any])//Return live news api information.
    //TODO: New api will come here which are in the news module & based on return API information.
}

extension NewsAPI: ApiTargetType {
    
    //Path to return the complete request URL, i.e BaseURL + EndURL
    var path: String {
        var servicePath = ""
        switch self {
        case .liveNews:
            servicePath = "/v1/news"
        }
        return self.baseURL.appending(servicePath)
    }
    
    //Headers to the request
    public var headers: HTTPHeaders? {
        return ["":""]
    }
    
    //parameters to the request
     var parameters: [String: Any]? {
        switch self {
        case let .liveNews(parameters):
            return parameters
        }
    }
    
    //method to the request
    var method:HTTPMethod {
        switch self {
        case .liveNews:
            return .get
        }
    }
    
    //Encoding type of api request
    var encoding:ParameterEncoding {
        switch self {
        case .liveNews:
            return URLEncoding.default
        }
    }
}
