//
//  NewsAPI.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///NewsAPI file to encapsulate API request info i.e EndURL, Param, Type, Headers & Task & this file depend on each type of Module that are present in the application.
///

import Foundation
import Moya

// MARK: - Provider support

public enum NewsAPI {
    case liveNews(parameters: [String: Any])//Return live news api information.
    //New api will come here which are in the news module & based on return API information.
}

extension NewsAPI: TargetType {
    
    public var baseURL: URL { return URL(string: AppConstant.baseURL)! }
    
    public var path: String {
        switch self {
        case .liveNews:
            return "/v1/news"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .liveNews:
            return .get
        }
    }
    
    typealias Parameters = [String: Any]
    
    var parameters: Parameters? {
        switch self {
        case let .liveNews(parameters):
            return parameters
        }
    }
    
    public var headers: [String : String]? {
        return ["":""]
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .liveNews(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
