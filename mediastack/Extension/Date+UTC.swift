//
//  Date+UTC.swift
//  mediastack
//
//  Created by Mukesh Lokare on 07/03/22.
//

import Foundation

extension Date {
    func convertToUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
