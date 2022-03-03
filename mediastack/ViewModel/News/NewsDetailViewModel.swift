//
//  NewsDetailViewModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 03/03/22.
//

import Foundation

protocol NewsDetailViewModelProtocol{
    //Output
    var url:URL? {get}
    var source:String? {get}
}
class NewsDetailViewModel: NewsDetailViewModelProtocol{
    //Instance
    var news: News?
    
    //Initialiser
    init(news: News?){
        self.news = news
    }
    
    var url: URL?{
        return URL(string: news?.url ?? "")
    }
    
    var source: String?{
        return news?.source
    }
}
