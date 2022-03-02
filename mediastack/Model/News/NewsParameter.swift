//
//  NewsParameter.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///NewsParameter file is to send parameter to live news api.
///

import Foundation

struct NewsParameter: Codable {
    var access_key : String
    var sources : String?
    var categories : String?
    var countries : String?
    var languages : String?
    var keywords: String?
    var sort: String?
    var offset: Int = 0
    var limit: Int = 100
}
