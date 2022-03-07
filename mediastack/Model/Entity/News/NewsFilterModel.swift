//
//  NewsFilterModel.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//
//
///NewsFilterModel class used to manage the filter selection.
///Used class instead of struct because selected flag need to manage dynamically.
///One time filter apply state not managed.
///

import Foundation

class NewsFilterModel{
    var name: String
    var filters: [SubFilter]
    
    init(name:String, filters:[SubFilter]){
        self.name = name
        self.filters = filters
    }
}

class SubFilter{
    var name:String
    var selected: Bool
    init(name:String, selected:Bool){
        self.name = name
        self.selected = selected
    }
}
