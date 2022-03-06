//
//  ApiTargetType.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import Foundation
import Alamofire

public protocol ApiTargetType {

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// Provides stub data for use in testing. Default is `Data()`.
    var sampleData: Data { get }

    /// Provides parameters
    var parameters: [String: Any]? {get}
    
    /// The headers to be used in the request.
    var headers: HTTPHeaders? { get }
    
    /// The parameter encoding
    var encoding:ParameterEncoding {get}
}

public extension ApiTargetType {
    /// Provides stub data for use in testing. Default is `Data()`.
    var sampleData: Data { Data() }
}
