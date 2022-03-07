//
//  String+Date.swift
//  mediastack
//
//  Created by Mukesh Lokare on 07/03/22.
//

import Foundation

extension String{
    
    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:self)!
    }
}
