//
//  News.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//
///NewsModel file is model to manage the entities which are getting in live news api response.
///

import Foundation

struct News: Codable{
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var source: String?
    var image: String?
    var category: String?
    var language: String?
    var country: String?
    var published_at: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case source = "source"
        case image = "image"
        case category = "category"
        case language = "language"
        case country = "country"
        case published_at = "published_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.source = try container.decodeIfPresent(String.self, forKey: .source) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.published_at = try container.decodeIfPresent(String.self, forKey: .published_at) ?? ""
    }
}

struct Pagination: Codable{
    var limit: Int
    var offset: Int
}
