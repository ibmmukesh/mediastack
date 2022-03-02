//
//  ApiResponseModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

/// ApiResponseModel file is used to parse json in generic way depend on base key-value of API archtecture.

import Foundation

enum ApiResponse<T> {
    case success(value: T)
    case failure(error: Error)
}

struct ApiResponseModel<T : Codable>: Codable {
    
    var pagination: Pagination?
    var data : T?

    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case data = "data"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pagination = try container.decodeIfPresent(Pagination.self, forKey: .pagination)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}

struct ApiError: Codable {

    var message: String
    var documentationUrl: String
   
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case documentationUrl = "documentation_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.documentationUrl = try container.decodeIfPresent(String.self, forKey: .documentationUrl) ?? ""
    }
}
