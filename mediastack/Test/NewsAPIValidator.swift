//
//  File.swift
//  mediastack
//
//  Created by Mukesh Lokare on 03/03/22.
//

///APIValidator class to manage the unit test case passing successfuly or not.
///

import Foundation
import UIKit

struct NewsAPIValidator{
    
    init(){}
    
    internal func isCountryValid(countries: [String]) -> Bool{
        return countries.count >= 1
    }
    
    internal func isLanguagesValid(languages: String) -> Bool{
        return languages.count > 1
    }
   
    internal func isCategoriesValid(category: String) -> Bool{
        return category.count > 1
    }
}
